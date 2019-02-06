package routers

import (
	"github.com/gin-gonic/gin"

	_ "github.com/benkauffman/go-boilerplate-api/docs"
	ginSwagger "github.com/swaggo/gin-swagger"
	"github.com/swaggo/gin-swagger/swaggerFiles"

	"github.com/benkauffman/go-boilerplate-api/middleware/jwt"
	"github.com/benkauffman/go-boilerplate-api/pkg/setting"
	"github.com/benkauffman/go-boilerplate-api/routers/api"
)

func InitRouter() *gin.Engine {
	r := gin.New()

	r.Use(gin.Logger())

	r.Use(gin.Recovery())
	gin.SetMode(setting.ServerSetting.RunMode)

	r.GET("/auth", api.GetAuth)
	r.GET("/swagger/*any", ginSwagger.WrapHandler(swaggerFiles.Handler))

	apiv1 := r.Group("/api/v1")
	apiv1.Use(jwt.JWT())
	{

	}

	return r
}
