<?php
namespace Auth\Controller;

use Zend\Mvc\Controller\AbstractActionController;
use Zend\View\Model\ViewModel;
use Auth\Model\Auth;          // <-- Add this import
use Auth\Form\AuthForm;       // <-- Add this import

class AuthController extends Zend\Controller\Action
{

    public function loginAction()
    {
        $db = $this->_getParam('db');

        $loginForm = new Default_Form_Auth_Login($_POST);

        if ($loginForm->isValid()) {

            $adapter = new Zend\Auth\Adapter\DbTable(
                $db,
                'users',
                'userName',
                'passWord'
                );

            $adapter->setIdentity($loginForm->getValue('userName'));
            $adapter->setCredential($loginForm->getValue('passWord'));

            $result = $auth->authenticate($adapter);

            if ($result->isValid()) {
                $this->_helper->FlashMessenger('Successful Login');
                $this->redirect('/');
                return;
            }

        }

        $this->view->loginForm = $loginForm;

    }

}