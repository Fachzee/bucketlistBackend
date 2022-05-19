<?php
require __DIR__ . '/classes/JwtHandler.php';

class Auth extends JwtHandler
{
    protected $db;
    protected $headers;
    protected $token;

    public function __construct($db, $headers)
    {
        parent::__construct();
        $this->db = $db;
        $this->headers = $headers;
    }

    public function isValid()
    {

        if (array_key_exists('Authorization', $this->headers) && preg_match('/Bearer\s(\S+)/', $this->headers['Authorization'], $matches)) {

            $data = $this->jwtDecodeData($matches[1]);

            if (
                isset($data['data']->user_id) && $user = $this->fetchUser($data['data']->user_id)
                ) :
                $userList = $this->fetchUserList($data['data']->user_id);
                $userAllList = $this->fetchAllUserList($data['data']->user_id);
                return [
                    "success" => 1,
                    "user" => $user,
                    "userlist" => $userList,
                    "userAlllist" => $userAllList
                ];
            else :
                return [
                    "success" => 0,
                    "message" => $data['message'],
                ];
            endif;
        } else {
            return [
                "success" => 0,
                "message" => "Token not found in request"
            ];
        }
    }

    protected function fetchUser($user_id)
    {
        try {
            $fetch_user_by_id = "SELECT `name`,`email`,`nationality`,`age`,`id`  FROM `users` WHERE `id`=:id";
            $query_stmt = $this->db->prepare($fetch_user_by_id);
            $query_stmt->bindValue(':id', $user_id, PDO::PARAM_INT);
            $query_stmt->execute();

            if ($query_stmt->rowCount()) :
                return $query_stmt->fetch(PDO::FETCH_ASSOC);
            else :
                return false;
            endif;
        } catch (PDOException $e) {
            return null;
        }
    }

    protected function fetchUserList($user_id)
    {
        try {
            $fetch_userList_by_id = "SELECT `itemList`,`itemCountry`  FROM `list_item` WHERE `user_id`=:id";
            $query_stmt = $this->db->prepare($fetch_userList_by_id);
            $query_stmt->bindValue(':id', $user_id, PDO::PARAM_INT);
            $query_stmt->execute();

            if ($query_stmt->rowCount()) :
                return $query_stmt->fetchALL(PDO::FETCH_ASSOC);
            else :
                return false;
            endif;
        } catch (PDOException $e) {
            return null;
        }
    }

    protected function fetchAllUserList()
    {
        try {
            $fetch_allusers = "SELECT users.id,users.name,users.age,users.email,users.nationality,list_item.itemList,list_item.itemCountry FROM list_item,users WHERE users.id=list_item.user_id ORDER BY list_item.user_id DESC";
            $query_stmt = $this->db->prepare($fetch_allusers);
            $query_stmt->execute();

            if ($query_stmt->rowCount()) :
                return $query_stmt->fetchALL(PDO::FETCH_ASSOC);
            else :
                return false;
            endif;
        } catch (PDOException $e) {
            return null;
        }
    }
}