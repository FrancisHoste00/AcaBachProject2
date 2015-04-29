<?php
namespace Auth\Model;

use Zend\Db\TableGateway\TableGateway;

class UsersTable
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
    public function getUser($idUsers)
    {
        $idUsers  = (int) $idUsers;
        $rowset = $this->tableGateway->select(array('idUsers' => $idUsers));
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
            'userName' 				      => $auth->userName,
            'passWord'  		          => $auth->passWord,
            'UserGroup_idUserGroup'  	  => $auth->UserGroup_idUserGroup,
        );
		// If there is a method getArrayCopy() defined in Auth you can simply call it.
		// $data = $auth->getArrayCopy();
        $idUsers = (int)$auth->idUsers;
        if ($idUsers == 0) {
            $this->tableGateway->insert($data);
        } else {
            if ($this->getUser($idUsers)) {
                $this->tableGateway->update($data, array('idUsers' => $idUsers));
            } else {
                throw new \Exception('Form id does not exist');
            }
        }
    }
	
    public function deleteUser($id)
    {
        $this->tableGateway->delete(array('idUsers' => $idUsers));
    }	
}