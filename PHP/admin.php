<?php
	require "dataBase.php";
	if(isset($_POST["btnSend"])){
		$Name = $_POST["Name"];
		$Link = $_POST["Link"];
        $Image = $_POST["Image"];
		$qr = "INSERT INTO Music VALUES(null, '$Name', '$Link', '$Image')";
		mysql_query($qr);
	}
?>

<table border="1" width="500px">
	<tr>
		<td>ID</td>
		<td>Name</td>
		<td>Link</td>
        <td>Image</td>
	</tr>
	<?php
		$Music = mysql_query("SELECT * FROM Music");
		while ($row = mysql_fetch_array($Music)) {
			
	?>
	<tr>
		<td><?php echo $row["ID"] ?></td>
		<td><?php echo $row["Name"] ?></td>
		<td><?php echo $row["Link"] ?></td>
        <td><?php echo $row["Image"] ?></td>
	</tr>
	<?php 
	}

	?>
</table>
<br/>
<form action="" method="POST">
	Name: <input type="text" name="Name" name="Name" /> <br/><br/>
	Link: <input type="text" name="Link" name="Link" /> <br/><br/>
    Image: <input type="text" name="Image" name="Image" /> <br/><br/>
	<input type="submit" name="btnSend" id="btnSend" value="Submit" />
</form>
