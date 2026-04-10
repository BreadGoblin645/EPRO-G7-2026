package com.animeCandles.helper;

import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.util.Properties;

public class ConnectionProvider {

    private static Connection connection;

    public static Connection getConnection() {
        try {
            if (connection == null || connection.isClosed()) {

                Properties props = new Properties();
                try (InputStream in = ConnectionProvider.class.getClassLoader()
                        .getResourceAsStream("db.properties")) {
                    if (in == null) {
                        throw new RuntimeException("db.properties no encontrado en classpath");
                    }
                    props.load(in);
                }

                String host = props.getProperty("db.host");
                String port = props.getProperty("db.port");
                String dbName = props.getProperty("db.name");
                String user = props.getProperty("db.user");
                String pass = props.getProperty("db.password");

                String url = "jdbc:mysql://" + host + ":" + port + "/" + dbName +
                        "?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC";

                Class.forName("com.mysql.cj.jdbc.Driver");
                connection = DriverManager.getConnection(url, user, pass);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return connection;
    }
}
