package e

var MsgFlags = map[int]string{
	SUCCESS:                        "Okay",
	ERROR:                          "Fail",
	INVALID_PARAMS:                 "Invalid parameters",
	ERROR_AUTH_CHECK_TOKEN_FAIL:    "Token Check Failed",
	ERROR_AUTH_CHECK_TOKEN_TIMEOUT: "Token Check Timed Out",
	ERROR_AUTH_TOKEN:               "Token Failed",
	ERROR_AUTH:                     "Token Error",
}

func GetMsg(code int) string {
	msg, ok := MsgFlags[code]
	if ok {
		return msg
	}

	return MsgFlags[ERROR]
}
