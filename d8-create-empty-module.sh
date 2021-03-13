#!/bin/bash
set -e
# Description: Create empty module structure.
script_name=$(basename "${0}")

module_name=$1

# Error handling.
    cmd_eg=$(printf "%s\n%s\n%s\n" \
            "  e.g. ./${script_name} <MODULE_NAME>"\
    )
    
    if [ -z "${module_name}" ]; then
        echo "Error: Module name can't empty. Allow characters: [A-Z_] Aborted!"
        echo "${cmd_eg}"
        exit 1;
    fi

# Create module dir.
    mkdir "${module_name}"

# Change *.info.yml
cat << EOF > "${module_name}/${module_name}.info.yml"
name: 'MODULE NAME'
description: DESCRIPTION BLA BLA.
package: PACKAGE_NAME
type: module
core: 8.x
dependencies:
  - field
EOF

# Create config/ to hold *.yml files.
    config_dir="${module_name}/config/install/"
    mkdir -p "${config_dir}"

# Create src/ for routing
    routing_yml="${module_name}/${module_name}.routing.yml"
    src_dir="${module_name}/src/"
    > "${routing_yml}"

# Create Form routing
    form_dir="${module_name}/src/Form/"
    mkdir -p "${form_dir}"
    
cat << EOF >> "${routing_yml}"
${module_name}.my_form:
  path: '/my_form'
  defaults:
    _form: 'Drupal\\${module_name}\Form\MyForm'
    _title: 'My Form'
  requirements:
    _permission: 'access content'
EOF


# Dipslay info.
    echo "${module_name} created."
    tree "${module_name}"
