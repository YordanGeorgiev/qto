#!/bin/bash
#------------------------------------------------------------------------------
# @description Unzips and activates a predefined list of WordPress plugins using WP-CLI.
# @example ./install-all-wp-plugins.sh
# @prereq WP-CLI, unzip, sudo privileges as www-data, WordPress installation at /var/www/html
#------------------------------------------------------------------------------

# Define the WordPress root directory
WP_PATH="/var/www/html"
PLUGIN_DIR="/var/www/html/wp-content/plugins"

# Array of plugin zip files
plugins=(
    "advanced-custom-fields-pro-6.3.3.zip"
    "autoptimize-3.1.1.zip"
    "child-theme-configurator-2.6.6.zip"
    "complianz-gdpr-7.1.0.zip"
    "custom-post-type-ui-1.17.1.zip"
    "disable-gutenberg-3.1.2.zip"
    "forminator-1.33.0.zip"
    "insert-headers-and-footers-2.1.14.zip"
    "js_composer.zip"
    "loco-translate-2.6.10.zip"
    "polylang-pro-3.6.3.zip"
    "safe-svg-2.5.2.zip"
    "wp-fastest-cache-1.2.9.zip"
    "yoast-seo-23.0.zip"
)

# Loop through each plugin and install it
for plugin in "${plugins[@]}"; do
    # Unzip the plugin to the WordPress plugins directory
    echo "Unzipping $plugin..."
    sudo -u www-data unzip "$PLUGIN_DIR/$plugin" -d "$WP_PATH/wp-content/plugins/" || { echo "Failed to unzip $plugin"; continue; }
    
    # Extract the plugin slug from the zip file name
    PLUGIN_SLUG=$(basename "$plugin" .zip)
    echo "Activating $PLUGIN_SLUG..."
    
    # Activate the plugin using WP-CLI
    sudo -u www-data wp plugin activate "$PLUGIN_SLUG" --path="$WP_PATH" || { echo "Failed to activate $PLUGIN_SLUG"; continue; }
    
    echo "$PLUGIN_SLUG activated successfully."
done

# Verify the installation
sudo -u www-data wp plugin list --path="$WP_PATH"

echo "All plugins processed."

# +----------------------------+----------+--------+---------+----------------+-------------+
# | name                       | status   | update | version | update_version | auto_update |
# +----------------------------+----------+--------+---------+----------------+-------------+
# | advanced-custom-fields-pro | active   | none   | 6.3.3   |                | off         |
# | autoptimize                | inactive | none   | 3.1.11  |                | off         |
# | child-theme-configurator   | active   | none   | 2.6.6   |                | off         |
# | complianz-gdpr             | inactive | none   | 7.1.0   |                | off         |
# | custom-post-type-ui        | inactive | none   | 1.17.1  |                | off         |
# | disable-gutenberg          | active   | none   | 3.1.2   |                | off         |
# | forminator                 | inactive | none   | 1.33    |                | off         |
# | loco-translate             | inactive | none   | 2.6.10  |                | off         |
# | polylang-pro               | inactive | none   | 3.6.3   |                | off         |
# | safe-svg                   | active   | none   | 2.2.5   |                | off         |
# | js_composer                | active   | none   | 7.6     |                | off         |
# | insert-headers-and-footers | inactive | none   | 2.1.14  |                | off         |
# | wp-fastest-cache           | inactive | none   | 1.2.9   |                | off         |
# | wp-file-manager            | active   | none   | 7.2.9   |                | off         |
# +----------------------------+----------+--------+---------+----------------+-------------+
# run-bsh ::: v3.8.0
