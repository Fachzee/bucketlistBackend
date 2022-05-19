<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Headers: access");
header("Access-Control-Allow-Methods: POST");
header("Content-Type: application/json; charset=UTF-8");
header("Access-Control-Allow-Headers: Content-Type, Access-Control-Allow-Headers, Authorization, X-Requested-With");

require __DIR__ . '/classes/Database.php';
$db_connection = new Database();
$conn = $db_connection->dbConnection();

function msg($success, $status, $message, $extra = [])
{
    return array_merge([
        'success' => $success,
        'status' => $status,
        'message' => $message
    ], $extra);
}

// DATA FORM REQUEST
$data = json_decode(file_get_contents("php://input"), true);
$returnData = [];

if ($_SERVER["REQUEST_METHOD"] != "POST") :

    $returnData = msg(0, 404, 'Page Not Found!');

// IF THERE ARE NO EMPTY FIELDS THEN-
else :
    foreach ($data as $key => $value) {   
        $userid = trim($value["userid"]);
        $itemList = trim($value["itemList"]);
        $itemCountry = trim($value["itemCountry"]);
    
        if (strlen($itemList) < 1) :
            $returnData = msg(0, 422, 'Field cannot be empty!');
    
        elseif (strlen($itemCountry) < 1) :
            $returnData = msg(0, 422, 'Field cannot be empty!');
    
        else :
            try {
                    $insert_query = "INSERT INTO `list_item`(`user_id`,`itemList`,`itemCountry`) VALUES(:userid,:itemList,:itemCountry)";
    
                    $insert_stmt = $conn->prepare($insert_query);
    
                    // DATA BINDING
                    $insert_stmt->bindValue(':userid', $userid, PDO::PARAM_STR);
                    $insert_stmt->bindValue(':itemList', $itemList, PDO::PARAM_STR);
                    $insert_stmt->bindValue(':itemCountry', $itemCountry, PDO::PARAM_STR);
    
                    $insert_stmt->execute();
    
                    $returnData = msg(1, 201, 'Bucketlist item added sucessfully');
    
            } catch (PDOException $e) {
                $returnData = msg(0, 500, $e->getMessage());
            }
        endif;
      }
endif;

echo json_encode($returnData);