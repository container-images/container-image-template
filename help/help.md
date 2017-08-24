% {{ config.os.name }} (1) Container Image Pages
% MAINTAINER
% DATE

# NAME
{{ spec.name }} - {{ spec.description }}

# DESCRIPTION
Describe how image is used (user app, service, base image, builder image, etc.), the services or features it provides, and environment it is intended to run in (stand-alone docker, atomic super-privileged, oc multi-container app, etc.).

# USAGE
Describe how to run the image as a container and what factors might influence the behavior of the image itself. Provide specific command lines that are appropriate for how the container should be run. Here is an example for a container image meant to be run by the atomic command:

To pull the container and set up the host system for use by the XYZ container, run:

    # atomic install XYZimage

To run the XYZ container (after it is installed), run:

    # atomic run XYZimage

To remove the XYZ container (not the image) from your system, run:

    # atomic uninstall XYZimage

Also, describe default configuration options (when defined): hostname, domainname, user ID run as, exposed ports, volumes, working directory, command run by default, etc.

{{ spec.distro_specific_help }}

# ENVIRONMENT VARIABLES
Explain all environment variables available to run the image in different ways without the need of rebuilding the image. Change variables on the docker command line with -e option. For example:

MYSQL_PASSWORD=mypass
                The password set for the current MySQL user.

# LABELS
Describe LABEL settings (from the Dockerfile that created the image) that contains pertinent information.
For containers run by atomic, that could include INSTALL, RUN, UNINSTALL, and UPDATE LABELS. Others could
include BZComponent, Name, Version, Release, and Architecture. This section is optional.


# SECURITY IMPLICATIONS
If you expose ports or run with privileges, note those and provide an explanation. For example:

-d
    Runs continuously as a daemon process in the background

-p 9000:9000
    Opens  container  port  9000  and  maps it to the same port on the Host.


# HISTORY
Similar to a Changelog of sorts which can be as detailed as the maintainer wishes.

# SEE ALSO

Does Red Hat provide MariaDB technical support on RHEL 7? https://access.redhat.com/solutions/1247193
Install and Deploy a Mariadb Container Image https://access.redhat.com/documentation/en/red-hat-enterprise-linux-atomic-host/7/single/getting-started-guide/#install_and_deploy_a_mariadb_container
