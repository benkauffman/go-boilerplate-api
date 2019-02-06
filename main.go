package main

import (
	"fmt"
	"log"
	"net/http"

	"github.com/benkauffman/go-boilerplate-api/pkg/logging"

	"github.com/benkauffman/go-boilerplate-api/db"
	"github.com/benkauffman/go-boilerplate-api/models"
	"github.com/benkauffman/go-boilerplate-api/pkg/gredis"
	"github.com/benkauffman/go-boilerplate-api/pkg/setting"
	"github.com/benkauffman/go-boilerplate-api/routers"
)

func init() {

	log.Printf("[info] initialize setting")
	setting.Setup()

	log.Printf("[info] initialize logging")
	logging.Setup()

	log.Printf("[info] initialize db")
	db.Setup()

	log.Printf("[info] initialize models")
	models.Setup()

	log.Printf("[info] initialize gredis")
	gredis.Setup()

}

// @title Boilerplate API
// @version 1.0
// @description API to demo RESTful capabilities in go
// @termsOfService https://github.com/benkauffman/go-boilerplate-api
// @license.name MIT
// @license.url https://github.com/benkauffman/go-boilerplate-api/blob/master/LICENSE
func main() {
	routersInit := routers.InitRouter()
	readTimeout := setting.ServerSetting.ReadTimeout
	writeTimeout := setting.ServerSetting.WriteTimeout
	endPoint := fmt.Sprintf(":%d", setting.ServerSetting.HttpPort)
	maxHeaderBytes := 1 << 20

	server := &http.Server{
		Addr:           endPoint,
		Handler:        routersInit,
		ReadTimeout:    readTimeout,
		WriteTimeout:   writeTimeout,
		MaxHeaderBytes: maxHeaderBytes,
	}

	log.Printf("[info] start http server listening %s", endPoint)

	server.ListenAndServe()

	// If you want Graceful Restart, you need a Unix system and download github.com/fvbock/endless
	//endless.DefaultReadTimeOut = readTimeout
	//endless.DefaultWriteTimeOut = writeTimeout
	//endless.DefaultMaxHeaderBytes = maxHeaderBytes
	//server := endless.NewServer(endPoint, routersInit)
	//server.BeforeBegin = func(add string) {
	//	log.Printf("Actual pid is %d", syscall.Getpid())
	//}
	//
	//err := server.ListenAndServe()
	//if err != nil {
	//	log.Printf("Server err: %v", err)
	//}
}
