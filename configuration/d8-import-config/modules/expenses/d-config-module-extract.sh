#!/bin/bash
set -e
# Description: Extract content type configuration(YAML) from existing Drupal installation and put these configuration files into a new module to be installed on another website.
#	From admin/config/development/configuration, export all.
#		Paste this script where config-*.tar.gz is located.
#   TIP: When creating a content type use a unique identifier so that it will be easier to extract.

config_gz=$(\ls config-*.tar.gz | sort -r | head -n1);
echo "Processing ${config_gz}";

tmp_dir="tmp-module-98562";
	rm -rf "${tmp_dir}";
    mkdir -p "${tmp_dir}";

identifier_1="expense"
identifier_2="_ex_"
tar -xzf "${config_gz}" -C "${tmp_dir}" &&
(
	cd "${tmp_dir}";
	
	work_dir="zzz"
	    mkdir -p "${work_dir}"
	
    # Grab *.yml matching identifiers.
        mv *."${identifier_1}"*.yml "${work_dir}"
        mv *"${identifier_2}"*.yml "${work_dir}"

    # Remove uuid and '_core:' lines.
        cd "${work_dir}";
        sed -i '/^uuid: /d' *.yml;
        sed -i '/^_core:$/,/^  default_config_hash: /d' *.yml;
        chown -R www-data:www-data *;
        cd ..;
        
    # Update config/install/
        \mv "${work_dir}/"*.yml ../config/install/;
)

# Clean up.
    rm -rf "${tmp_dir}"