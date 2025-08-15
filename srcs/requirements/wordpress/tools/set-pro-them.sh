#!/bin/bash
echo "🌟 Setting up complete professional sample website..."
echo "Date: 2025-08-14 16:25:38 UTC"
echo "User: 1MhDjant23"

# Install theme
echo "🎨 Installing Astra theme..."
wp theme install astra --activate --allow-root --path=/var/www/wordpress

# Install plugins with correct names
echo "🔌 Installing essential plugins..."
wp plugin install elementor --activate --allow-root --path=/var/www/wordpress
wp plugin install wordpress-seo --activate --allow-root --path=/var/www/wordpress
wp plugin install contact-form-7 --activate --allow-root --path=/var/www/wordpress
wp plugin install advanced-custom-fields --activate --allow-root --path=/var/www/wordpress
wp plugin install code-syntax-block --activate --allow-root --path=/var/www/wordpress
wp plugin install w3-total-cache --activate --allow-root --path=/var/www/wordpress

echo "✅ Plugins installed successfully!"