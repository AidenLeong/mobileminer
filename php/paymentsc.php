<?php
error_reporting(0);
include_once("dbconnect.php");
$userid = $_POST['userid'];
$amount = $_POST['amount'];
$orderid = $_POST['orderid'];
$newwl = $_POST['newwl'];
$receiptid ="walletpayment";


 $sqlcart ="SELECT CART.ID, CART.CQUANTITY, PRODUCT.PRICE FROM CART INNER JOIN PRODUCT ON CART.ID = PRODUCT.ID WHERE CART.EMAIL = '$userid'";
        $cartresult = $conn->query($sqlcart);
        if ($cartresult->num_rows > 0)
        {
        while ($row = $cartresult->fetch_assoc())
        {
            $id = $row["ID"];
            $cq = $row["CQUANTITY"]; //cart qty
            $pr = $row["PRICE"];
            $sqlinsertcarthistory = "INSERT INTO CARTHISTORY(EMAIL,ORDERID,BILLID,ID,CQUANTITY) VALUES ('$userid','$orderid','$receiptid','$id','$cq')";
            $conn->query($sqlinsertcarthistory);
            
            $selectproduct = "SELECT * FROM PRODUCT WHERE ID = '$id'";
            $productresult = $conn->query($selectproduct);
             if ($productresult->num_rows > 0){
                  while ($rowp = $productresult->fetch_assoc()){
                       $id = $row["ID"];
            $cq = $row["CQUANTITY"]; //cart qty
            $pr = $row["PRICE"];
            $sqlinsertcarthistory = "INSERT INTO CARTHISTORY(EMAIL,ORDERID,BILLID,ID,CQUANTITY) VALUES ('$userid','$orderid','$receiptid','$id','$cq')";
                    $prquantity = $rowp["QUANTITY"];
                    $newquantity = $prquantity - $cq; //quantity in store - quantity ordered by user
                    $newsold = $prevsold + $cq;
                    $sqlupdatequantity = "UPDATE PRODUCT SET QUANTITY = '$newquantity' WHERE ID = '$id'";
                    $conn->query($sqlupdatequantity);
                  }
             }
        }
        
       $sqldeletecart = "DELETE FROM CART WHERE EMAIL = '$userid'";
       $sqlinsert = "INSERT INTO PAYMENT(ORDERID,BILLID,USERID,TOTAL) VALUES ('$orderid','$receiptid','$userid','$amount')";
       
        $sqlupdatecredit = "UPDATE USER SET WALLET = '$newwl' WHERE EMAIL = '$userid'";
        
       $conn->query($sqldeletecart);
       $conn->query($sqlinsert);
       $conn->query($sqlupdatecredit);
       echo "success";
        }else{
            echo "failed";
        }

?>