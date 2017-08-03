<?php
	require "dataBase.php";
	$cot = $_GET["cot"];
	$Music = mysql_query("SELECT * FROM Music");
	$count = 0;
	while ($row = mysql_fetch_array($Music)) {
		$count = $count + 1;
		echo $row[$cot];
		if ($count < mysql_num_rows($Music))
			echo "#";
	}
?>
