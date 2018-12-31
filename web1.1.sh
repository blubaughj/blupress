#!/bin/bash
source /tmp/variables.sh

sudo mkdir -p $SITE_ROOT_DIR/{public_html,logs}

cd $SITE_ROOT_DIR/public_html


sudo mkdir -p $SITE_ROOT_DIR/src/
cd $SITE_ROOT_DIR/src/
sudo chown -R www-data:www-data $SITE_ROOT_DIR/

sudo wget -O /tmp/wordpress.tar.gz http://wordpress.org/latest.tar.gz
sudo -u www-data tar -xvf /tmp/wordpress.tar.gz --strip-components=1 -C $SITE_ROOT_DIR/public_html
sudo chown -R www-data:www-data $SITE_ROOT_DIR/public_html

cat > /etc/apache2/sites-enabled/example.conf << EOL
<Directory $SITE_ROOT_DIR/public_html>
        Require all granted
</Directory>
<VirtualHost *:80>
        ServerName $HOSTNAME
        ServerAlias www.$HOSTNAME
        ServerAdmin webmaster@localhost
        DocumentRoot $SITE_ROOT_DIR/public_html

        ErrorLog $SITE_ROOT_DIR/logs/error.log
        CustomLog $SITE_ROOT_DIR/logs/access.log combined

</VirtualHost>
EOL

cat > $SITE_ROOT_DIR/public_html/wp-config.php << EOL
<?php


// ** MySQL settings - You can get this info from your web host ** //
/** The name of the database for WordPress */
define( 'DB_NAME', '$DB_NAME' );

/** MySQL database username */
define( 'DB_USER', '$DB_USER' );

/** MySQL database password */
define( 'DB_PASSWORD', '$DB_PASSWORD' );

/** MySQL hostname */
define( 'DB_HOST', '$DBHOST' );

/** Database Charset to use in creating database tables. */
define( 'DB_CHARSET', 'utf8' );

/** The Database Collate type. Don't change this if in doubt. */
define( 'DB_COLLATE', '' );


define( 'AUTH_KEY',         '$AUTH_KEY' );
define( 'SECURE_AUTH_KEY',  '$SECURE_AUTH_KEY' );
define( 'LOGGED_IN_KEY',    '$LOGGED_IN_KEY' );
define( 'NONCE_KEY',        '$NONCE_KEY' );
define( 'AUTH_SALT',        '$AUTH_SALT' );
define( 'SECURE_AUTH_SALT', '$SECURE_AUTH_KEY' );
define( 'LOGGED_IN_SALT',   '$LOGGED_IN_SALT' );
define( 'NONCE_SALT',       '$NONCE_SALT' );


$table_prefix = 'wp_';


define( 'WP_DEBUG', false );

/* That's all, stop editing! Happy blogging. */

/** Absolute path to the WordPress directory. */
if ( ! defined( 'ABSPATH' ) ) {
	define( 'ABSPATH', dirname( __FILE__ ) . '/' );
}

/** Sets up WordPress vars and included files. */
require_once( ABSPATH . 'wp-settings.php' );
EOL
