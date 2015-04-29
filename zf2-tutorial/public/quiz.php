<?php
	session_start();
?>

<!DOCTYPE html>
<html>
<head>
	<title>Hello</title>
	<link rel="stylesheet" type="text/css" href="./css/bootstrap.css">
	<link rel="stylesheet" type="text/css" href="./css/bootstrap-theme.css">
	<link rel="stylesheet" type="text/css" href="./css/style.css">
</head>
<body>
	<div class="row">
    <div class="col-md-12">
        <div class="panel panel-default">
            <div class="panel-heading">
                <h3 class="panel-title">Welcome to the quiz, <?php echo $_SESSION['lastName']; ?> !</h3>
            </div>
            <div class="panel-body">
                <p>Questions will appear in order!</p>
            </div>
        </div>
    </div>
</div>
</body>
</html>