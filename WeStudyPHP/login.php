<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" 
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>

	<head>
		<title>连接数据库</title>
		<meta http-equiv="Content-Type" content="text/html;charset=UTF-8"/>
		<style>
			#center{
				MARGIN-RIGHT: auto;
				MARGIN-LEFT: auto;
				height:10px;
				width:400px;
				vertical-align:middle;
				horizontal-align:middle;
				line-height:10px;
			}
		</style>
	</head>
	
	<body>
		
		<?php
		/*
		 * 有个问题：此 php 文件放到服务器上之后，要在网页上执行以下才能生成 json 文件到服务器上，json 需要更新也需要重新执行此 php
		 */
		
		// json 解析与写入
		
		// 连接数据库的账户信息
		$server_name = "127.0.0.1";
		$user_name = "root";
		$passowrd = "zxc8585";
		$database_name = "qdm157490578_db";
		
		// 数据表
		$table_name = "WE_STUDY";
		// 查询表
		$query = "select * from $table_name ";
		
		// 将 json 数据写入文件，格式为 json
		// json 文件的路径、文件名
		$file_path = './Api_user/';
		$file_name = 'user.json';
		
		/*bool mkdir( string $pathname[, int $mode = 0777[, bool $recursive = false[,resource $context]]] )
		 * mode：默认的 mode 是 0777，意味着最大可能的访问权。mode 在 Windows 下被忽略。 
		 * recursive：是否递归创建子目录
		 * context：上下文
		 * 返回值：成功时返回 TRUE， 或者在失败时返回 FALSE
		 * if(file_exists($file)) 判断文件是否存在
		 */
		// 判断是否存在文件夹，不存在则创建文件
		if (!is_dir($file_path)) mkdir($file_path);
		
		// 以 w 方式打开\创建文件  句柄，该函数会创建文件并打开文件流
		$fp = fopen($file_path.$file_name, "w");
		
		// 连接数据库
		$link_database = mysql_connect ( $server_name, $user_name, $passowrd );
		if (! $link_database) {
			echo "数据库连接失败";
		}else {
// 			echo "数据库连接成功";
		}
		// 选择数据库
		mysql_select_db($database_name);
		// 设置字符集为 utf8 ，否则取出来为乱码
		mysql_query("set names utf8;");
		
		// 获取数据集
		$result = mysql_query($query);
		// 如果出错打印错误
		$err = mysql_error();
		if ($err) {
			echo "发生错误";
		}
		
		/*
		 * 查询出来的数据，分别将用户名和密码存入两个数组
		 * 作为在 json 中的 user_info
		 */
		$json_user= array();	// 用户名
		$json_pwd = array();	// 密码
		$json_subject = array();	// 科目
		$json_tel = array();	// 电话号码
		$json_email = array();	// 邮箱
		$json_studydata = array();	// studydata 学习数据
		// 遍历数据表，并将需要的数据加入到数组中
		while ($row = mysql_fetch_array($result)) {
			// 0 为 id，1 为用户名字段，2 为密码字段，3 - 科目，4 - 电话，5 - 邮箱，
			// 6 - pid，7 - studydata，8 - studystatus
			array_push($json_user, $row[1]);
			array_push($json_pwd, $row[2]);
			array_push($json_subject, $row[3]);
			array_push($json_tel, $row[4]);
			array_push($json_email, $row[5]);
			array_push($json_studydata, $row[7]);
		}
		
		// json 解析 将查询的用户表中的用户名和密码解析成 json 数据
		$arrResJSON = array();
		for ($i = 0; $i < count($json_user); $i ++) {
			array_push($arrResJSON,array(
					'usertable' => 1,
					'usernum' => $i,
					'userinfo' => array(
							name => $json_user[$i],
							pwd => $json_pwd[$i],
							subject => $json_subject[$i],
							tel => $json_tel[$i],
							email => $json_email[$i],
							studydata => $json_studydata[$i]
					)
			));
		}
		
		/* 处理数据库表，转换为 json 文件，缓存到服务器中
		 * 往文件追加 file_put_contents，从文件中读取 file_get_contents
		 * json_decode() 是解析 json 字符串的----解码
		 * json_encode() 是数组解析成 json 字符串----编码
		 * */
		// 将 json 数组写到 $file_path.$file_name 文件中
		fwrite($fp, json_encode($arrResJSON));
		
		// 打印 json
// 		echo json_encode($arrResJSON);
		
		// 关闭文件句柄
		fclose($fp);
		?>
		
		<span style="height='500px'">&nbsp;</span>
		<div id="center">
			<h1>用户登录</h1>
			<form name="form" id="form" action="./login.php" method="post">
				用户名:
				<input type="text" name="username"/>
				<br/><br/>
				密&nbsp;&nbsp;&nbsp;&nbsp;码:
				<input type="password" name="userpwd"/>
				<br/><br/>
				<input type="submit" value="登录"/>
			</form>
		
		<?php 
		// 网页
		// 用户登录
		
		// 获取表单数据中的用户名和密码
		// post 请求方法 $_POST[] 数组，数组的键名就是表单元素的 name 值
		$user_name = $_POST['username'];
		$user_pwd = $_POST['userpwd'];
		
		// 查询数据库中的用户名和密码
		$queryUserName = "select * from $table_name where username = '$user_name' ";
		$queryUserPWD = "select * from $table_name where userpwd = '$user_pwd'";
		
		// 获取查询数据集
		$resultName = mysql_query($queryUserName);
		$resultPWD = mysql_query($queryUserPWD);
		
		// 登录成功的页面
		$login_success = "./login_success.php";
		
		// 用户登录逻辑
		// 遍历数据表
		if ($user_name != "" && $user_pwd != "") {
			// 表单为空
			if ($rowName = mysql_fetch_array($resultName)) {
				// 用户名正确
				if ($resultPWD = mysql_fetch_array($resultPWD)) {
					// 密码正确
					// 登录成功，跳转
					echo "<script type='text/javascript'>";
					echo "location.href='$login_success'";
					echo "</script>";
					exit(json_encode($passowrd));
					
				}else {
					echo "密码错误 !";
				}
			}else {
				echo "账户不存在 !";
			}
		}else {
			// echo "用户名或密码不能为空 !";
		}
		?>
		</div>
		
		
		
	</body>
</html>