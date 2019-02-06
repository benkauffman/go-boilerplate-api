package db

import (
	"database/sql"
	"flag"
	"fmt"

	_ "github.com/go-sql-driver/mysql"
	"github.com/golang-migrate/migrate"
	"github.com/golang-migrate/migrate/database/mysql"
	_ "github.com/golang-migrate/migrate/source/file"

	"github.com/benkauffman/go-boilerplate-api/pkg/logging"
	"github.com/benkauffman/go-boilerplate-api/pkg/setting"
)

func Setup() {

	conn := fmt.Sprintf("%s:%s@tcp(%s)/?charset=utf8&parseTime=True&loc=Local&multiStatements=true",
		setting.DatabaseSetting.User,
		setting.DatabaseSetting.Password,
		setting.DatabaseSetting.Host)

	db, err := sql.Open(setting.DatabaseSetting.Type, conn)

	if err != nil {
		logging.Fatal(fmt.Sprintf("Could not connect to the host... %v", err))
	} else {
		logging.Info(fmt.Sprintf("Connected to host %s...", setting.DatabaseSetting.Host))
	}

	_, err = db.Exec(fmt.Sprintf("CREATE SCHEMA IF NOT EXISTS %s", setting.DatabaseSetting.Name))
	if err != nil {
		logging.Fatal(fmt.Sprintf("Could not create schema... %v", err))
	} else {
		logging.Info(fmt.Sprintf("Creating schema %s on host %s \"if not exists\"...", setting.DatabaseSetting.Name, setting.DatabaseSetting.Host))
	}

	_, err = db.Exec(fmt.Sprintf("USE %s", setting.DatabaseSetting.Name))

	var migrationDir = flag.String("migration.files", "./db/migrations", "Directory where the migration files are located ?")

	flag.Parse()

	if err := db.Ping(); err != nil {
		logging.Fatal(fmt.Sprintf("could not ping DB... %v", err))
	}

	// Run migrations
	driver, err := mysql.WithInstance(db, &mysql.Config{})
	if err != nil {
		logging.Fatal(fmt.Sprintf("Could not start sql migration... %v", err))
	}

	m, err := migrate.NewWithDatabaseInstance(fmt.Sprintf("file://%s", *migrationDir), "mysql", driver)

	if err != nil {
		logging.Fatal(fmt.Sprintf("migration failed... %v", err))
	}

	m.Steps(setting.DatabaseSetting.Version)

	//if err := m.Up(); err != nil && err != migrate.ErrNoChange {
	//	logging.Fatal(fmt.Sprintf("An error occurred while syncing the database.. %v", err))
	//}

	logging.Debug(fmt.Sprintf("Database migration complete"))
}
