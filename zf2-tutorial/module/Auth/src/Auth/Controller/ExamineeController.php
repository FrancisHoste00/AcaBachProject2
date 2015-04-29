<?php
namespace Auth\Controller;

use Zend\Mvc\Controller\AbstractActionController;
use Zend\View\Model\ViewModel;
use Auth\Model\Auth;
use Auth\Form\RegistrationForm;
use Auth\Form\RegistrationFilter;

session_start();

class ExamineeController extends AbstractActionController
{
	protected $registrationTable;	
	
	public function indexAction()
	{
		
		$form = new RegistrationForm();
		$form->get('submit')->setValue('Register');
		
		$request = $this->getRequest();
        if ($request->isPost()) {
			$form->setInputFilter(new RegistrationFilter($this->getServiceLocator()));
			$form->setData($request->getPost());
			 if ($form->isValid()) {			 
				$data = $form->getData();
				$data = $this->prepareData($data);
				$auth = new Auth();
				$auth->exchangeArray2($data);

				$this->getRegistrationTable()->saveUser($auth);

				$_SESSION['lastName'] = $data['lastName'];

				return $this->redirect()->toUrl("http://quiz.local/quiz.php");
			}			 
		}
		return new ViewModel(array('form' => $form));
	}
	
	public function prepareData($data)
	{
		$date = new \DateTime();
		$data['dateExam'] = $date->format('Y-m-d H:i:s');
		return $data;
	}
	
    public function getRegistrationTable()
    {
        if (!$this->registrationTable) {
            $sm = $this->getServiceLocator();
            $this->registrationTable = $sm->get('Auth\Model\RegistrationTable');
        }
        return $this->registrationTable;
    }	
}