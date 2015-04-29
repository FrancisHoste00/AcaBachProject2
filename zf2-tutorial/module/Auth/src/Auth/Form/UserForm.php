<?php
namespace Auth\Form;

use Zend\Form\Form;

class UserForm extends Form
{
    public function __construct($name = null)
    {
        parent::__construct('registration');
        $this->setAttribute('method', 'post');
        $this->add(array(
            'name' => 'userName',
            'attributes' => array(
                'type'  => 'text',
            ),
            'options' => array(
                'label' => 'Username',
            ),
        ));
		
        $this->add(array(
            'name' => 'passWord',
            'attributes' => array(
                'type'  => 'password',
            ),
            'options' => array(
                'label' => 'Password',
            ),
        ));

        $this->add(array(
            'name' => 'UserGroup_idUserGroup',
			'type' => 'Zend\Form\Element\Select',
            'options' => array(
                'label' => 'Role',
				'value_options' => array(
					'1' => 'Admin',
					'2' => 'Examinator',
				),
            ),
        ));

        $this->add(array(
            'name' => 'submit',
            'attributes' => array(
                'type'  => 'submit',
                'value' => 'Go',
                'id' => 'submitbutton',
            ),
        )); 
    }
}