<?php
namespace Auth\Model;

use Zend\InputFilter\Factory as InputFactory;
use Zend\InputFilter\InputFilter;
use Zend\InputFilter\InputFilterAwareInterface;
use Zend\InputFilter\InputFilterInterface;

// the object will be hydrated by Zend\Db\TableGateway\TableGateway
class Auth implements InputFilterAwareInterface
{
    public $idUsers;
    public $userName;
    public $passWord;	
    public $UserGroup_idUserGroup;
	// Hydration
	// ArrayObject, or at least implement exchangeArray. For Zend\Db\ResultSet\ResultSet to work
    public function exchangeArray($data) 
    {
        $this->idUsers      = (!empty($data['idUsers'])) ? $data['idUsers'] : null;
        $this->userName     = (!empty($data['userName'])) ? $data['userName'] : null;
        $this->userName     = (!empty($data['passWord'])) ? $data['passWord'] : null;
        $this->UserGroup_idUserGroup = (!empty($data['UserGroup_idUserGroup'])) ? $data['UserGroup_idUserGroup'] : null;
    }

    public function exchangeArray2($data) 
    {
        $this->lastName         = (!empty($data['lastName'])) ? $data['lastName'] : null;
        $this->firstName        = (!empty($data['firstName'])) ? $data['firstName'] : null;
        $this->email            = (!empty($data['email'])) ? $data['email'] : null;
        $this->dateExam         = (!empty($data['dateExam'])) ? $data['dateExam'] : null;
        $this->idExaminees      = (!empty($data['idExaminees'])) ? $data['idExaminees'] : 0 ;
    }

	// Extraction. The Registration from the tutorial works even without it.
	// The standard Hydrator of the Form expects getArrayCopy to be able to bind
    public function getArrayCopy()
    {
        return get_object_vars($this);
    }
	
	
	protected $inputFilter;
    public function setInputFilter(InputFilterInterface $inputFilter)
    {
        throw new \Exception("Not used");
    }
	
    public function getInputFilter()
    {
        if (!$this->inputFilter) {
            $inputFilter = new InputFilter();
            $factory     = new InputFactory();
            $inputFilter->add($factory->createInput(array(
                'name'     => 'userName',
                'required' => true,
                'filters'  => array(
                    array('name' => 'StripTags'),
                    array('name' => 'StringTrim'),
                ),
                'validators' => array(
                    array(
                        'name'    => 'StringLength',
                        'options' => array(
                            'encoding' => 'UTF-8',
                            'min'      => 1,
                            'max'      => 100,
                        ),
                    ),
                ),
            )));
            $inputFilter->add($factory->createInput(array(
                'name'     => 'passWord',
                'required' => true,
                'filters'  => array(
                    array('name' => 'StripTags'),
                    array('name' => 'StringTrim'),
                ),
                'validators' => array(
                    array(
                        'name'    => 'StringLength',
                        'options' => array(
                            'encoding' => 'UTF-8',
                            'min'      => 1,
                            'max'      => 100,
                        ),
                    ),
                ),
            )));
            $this->inputFilter = $inputFilter;
        }
        return $this->inputFilter;
    }	
}