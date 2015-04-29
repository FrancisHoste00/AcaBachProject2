<?php
namespace Auth\Model;

use Zend\Db\TableGateway\TableGateway;

class RegistrationTable
{
    protected $tableGateway;

    public function __construct(TableGateway $tableGateway)
    {
        $this->tableGateway = $tableGateway;
    }
	
    public function fetchAll()
    {
        $resultSet = $this->tableGateway->select();
        return $resultSet;
    }
    public function getUser($idExaminees)
    {
        $idExaminees  = (int) $idExaminees;
        $rowset = $this->tableGateway->select(array('idExaminees' => $idExaminees));
        $row = $rowset->current();
        if (!$row) {
            throw new \Exception("Could not find row $id");
        }
        return $row;
    }
	
    public function saveUser(Auth $auth)
    {
		// for Zend\Db\TableGateway\TableGateway we need the data in array not object
        $data = array(
            'lastName' 				 => $auth->lastName,
            'firstName'              => $auth->firstName,
            'email'  		         => $auth->email,
            'dateExam'  		     => $auth->dateExam,
        );
		// If there is a method getArrayCopy() defined in Auth you can simply call it.
		// $data = $auth->getArrayCopy();
        $idExaminees = (int)$auth->idExaminees;
        if ($idExaminees == 0) {
            $this->tableGateway->insert($data);
        } else {
            if ($this->getUser($idExaminees)) {
                $this->tableGateway->update($data, array('idExaminees' => $idExaminees));
            } else {
                throw new \Exception('Form id does not exist');
            }
        }
    }
	
    public function deleteUser($id)
    {
        $this->tableGateway->delete(array('idExaminees' => $idExaminees));
    }	
}