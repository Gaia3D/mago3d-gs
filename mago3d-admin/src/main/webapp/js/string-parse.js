function getEncryptKey(key) {
	return CryptoJS.enc.Base64.parse(key.substring(16, 40));
}

function getEncryptIv(iv) {
	return CryptoJS.enc.Base64.parse(iv.substring(16, 40));
}