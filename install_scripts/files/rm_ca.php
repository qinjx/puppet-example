<?php
const RESULT_FAILED = "Failed";
const RESULT_OK = "OK";

$host = $_GET["host"];

$caFilePath = getCaFilePath($host);
if (is_file($caFilePath)) {
	$success = unlink($caFilePath) ? RESULT_OK : RESULT_FAILED;
} else {
	$success = RESULT_OK;
}

echo $success;

function getCaFilePath($host) {
	return "/var/lib/puppet/ssl/ca/signed/${host}.pem";
}