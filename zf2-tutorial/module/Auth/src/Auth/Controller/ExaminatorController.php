<?php
namespace Auth\Controller;

use Zend\Mvc\Controller\AbstractActionController;
use Zend\View\Model\ViewModel;
use Zend\Authentication\Result;
use Zend\Authentication\AuthenticationService;
use Zend\Authentication\Storage\Session as SessionStorage;
use Zend\Db\Adapter\Adapter as DbAdapter;
use Zend\Authentication\Adapter\DbTable as AuthAdapter;
use Auth\Model\Auth;
use Auth\Form\AuthForm;
use Zend\Db\Sql\Sql;

class ExaminatorController extends AbstractActionController
{
    public function indexAction()
    {
    	if($user = $this->identity()){
    		if($user->UserGroup_idUserGroup == 1){ //admin
				return $this->redirect()->toRoute('auth/default', array('controller' => 'admin', 'action' => 'index')); 
			}
    	}

    	$configArray = array(
    		'driver' => 'Pdo_Mysql',
    		'database' => 'zf2project',
    		'username' => 'root',
    		'password' => '');
    	$adapter = new DbAdapter($configArray);
    	$sql = new Sql($adapter);
    	
    	$select = $sql->select();
    	$select->from(array('q' => 'questions'))
    		->join(array('i' => 'interexamquestions'),
    		'q.idQuestions = i.idQuestions');

    	//$select = $sql->select();
    	//$select->from('interexamquestions');
    	//$select->where(array('idExam' => 2));

    	$statement = $sql->prepareStatementForSqlObject($select);
		$results = $statement->execute();

		return new ViewModel(array('results' => $results));
	}	
	
    public function loginAction()
	{
		if ($user = $this->identity()) {
			if($user->UserGroup_idUserGroup == 2){ //examinator
				return $this->redirect()->toRoute('auth/default', array('controller' => 'examinator', 'action' => 'index')); 
			}
			if($user->UserGroup_idUserGroup == 1){ //admin
				return $this->redirect()->toRoute('auth/default', array('controller' => 'admin', 'action' => 'index')); 
			}
		}

		$user = $this->identity();
		$form = new AuthForm();
		$form->get('submit')->setValue('Login');
		$messages = null;
		$request = $this->getRequest();
        if ($request->isPost()) {
			$authFormFilters = new Auth();
            $form->setInputFilter($authFormFilters->getInputFilter());	
			$form->setData($request->getPost());
			 if ($form->isValid()) {
				$data = $form->getData();
				$data['passWord'] = md5($data['passWord']);
				$sm = $this->getServiceLocator();
				$dbAdapter = $sm->get('Zend\Db\Adapter\Adapter');
				
				$config = $this->getServiceLocator()->get('Config');
				//$staticSalt = $config['static_salt'];
				$authAdapter = new AuthAdapter($dbAdapter,
										   'users', // there is a method setTableName to do the same
										   'userName', // there is a method setIdentityColumn to do the same
										   'passWord' // there is a method setCredentialColumn to do the same
										  );
				$authAdapter
					->setIdentity($data['userName'])
					->setCredential( $data['passWord'] )
				;
				
				$auth = new AuthenticationService();
				// or prepare in the globa.config.php and get it from there. Better to be in a module, so we can replace in another module.
				// $auth = $this->getServiceLocator()->get('Zend\Authentication\AuthenticationService');
				// $sm->setService('Zend\Authentication\AuthenticationService', $auth); // You can set the service here but will be loaded only if this action called.
				$result = $auth->authenticate($authAdapter);			
				
				switch ($result->getCode()) {
					case Result::FAILURE_IDENTITY_NOT_FOUND:
						// do stuff for nonexistent identity
						break;
					case Result::FAILURE_CREDENTIAL_INVALID:
						// do stuff for invalid credential
						break;
					case Result::SUCCESS:
						$storage = $auth->getStorage();
						$storage->write($authAdapter->getResultRowObject(
							null,
							'passWord'
						));
						$time = 1209600; // 14 days 1209600/3600 = 336 hours => 336/24 = 14 days
//						if ($data['rememberme']) $storage->getSession()->getManager()->rememberMe($time); // no way to get the session
						if ($data['rememberme']) {
							$sessionManager = new \Zend\Session\SessionManager();
							$sessionManager->rememberMe($time);
						}
						return $this->redirect()->toRoute('auth/default', array('controller' => 'examinator', 'action' => 'index')); 
						
						break;
					default:
						// do stuff for other failure
						break;
				}				
				foreach ($result->getMessages() as $message) {
					$messages .= "$message\n"; 
				}			
			 }
		}
		return new ViewModel(array('form' => $form, 'messages' => $messages));
	}
	
	public function logoutAction()
	{
		$auth = new AuthenticationService();
		// or prepare in the globa.config.php and get it from there
		// $auth = $this->getServiceLocator()->get('Zend\Authentication\AuthenticationService');
		
		if ($auth->hasIdentity()) {
			$identity = $auth->getIdentity();
		}			
		
		$auth->clearIdentity();
//		$auth->getStorage()->session->getManager()->forgetMe(); // no way to get the sessionmanager from storage
		$sessionManager = new \Zend\Session\SessionManager();
		$sessionManager->forgetMe();
		
		return $this->redirect()->toRoute('auth/default', array('controller' => 'examinator', 'action' => 'login'));		
	}	
}