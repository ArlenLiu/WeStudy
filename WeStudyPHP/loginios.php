<?php
/*
 * 这个页面中加入 HTML 标签后，iOS 端登录不了，只能是纯 PHP 代码？
 */

// 连接数据库的账户信息
$server_name = "127.0.0.1";
$user_name = "root";
$passowrd = "zxc8585";
$database_name = "qdm157490578_db";

// $output 为返回的状态码集
$output = array();

// 连接数据库
$link_database = mysql_connect ( $server_name, $user_name, $passowrd );
if (! $link_database) {
	echo "数据库连接失败";
// 	$output = array('data'=>NULL, 'code'=>"conn_db_err",'message'=>'数据库连接失败');
}else {
	// echo "数据库连接成功";
	// 选择数据库
	mysql_select_db($database_name);
	// 设置字符集为 utf8 ，否则取出来为乱码
	mysql_query("set names utf8;");
	// 数据表
	$table_name = "WE_STUDY";
	
	// POST 请求
	$user_name_ios = $_POST['usernameios'];
	$user_pwd_ios = $_POST['userpwdios'];
	
	// ???这里没用
	// 可在 iOS 客户端判断
	if (empty($user_name_ios) || empty($user_pwd_ios)) {
		$output = array('data'=>NULL, 'code'=>"failure",'message'=>'用户名或密码为空!');
		exit(json_encode($output));
	}
	
	// 查询语句
	$sql_username = "select * from $table_name where username = '$user_name_ios'";
	// $sql_userpwd = "select * from $table_name where userpwd = '$user_pwd_ios'";
	
	// 执行查询
	$query = mysql_query($sql_username);
	$rs = mysql_fetch_array($query);
	
	// 本地头像域名前缀
	$domainOfPortrait = 'http://localhost/westudy/portrait/';
	// LGJ 网站头像域名前缀
	$domainLGJPortrait = 'http://www.liugangjian.com/portrait/';
	
	// 登录判断
	if (is_array($rs)) {
		// 账户存在
		if ($user_pwd_ios == $rs['userpwd']) {
			// 密码正确
			$output = array(
					'data'=>NULL, 
					'code'=>"OK",
					'message'=>$rs['username'],
					'studydata'=>$rs['studydata'],
					'pidportrait'=>$domainOfPortrait.$rs['pid'].'.png'
			);
			exit(json_encode($output));
		}else {
			$output = array('data'=>NULL, 'code'=>"failure",'message'=>'用户名或密码错误!');
			exit(json_encode($output));
		}
	}else {
		$output = array('data'=>NULL, 'code'=>"failure",'message'=>'账户不存在!');
		exit(json_encode($output));
	}
}
?>