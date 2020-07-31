####################
# Temp functions for POM EG2 migration
####################

# Create a new directory and enter it
function _co_pom() {
    gprc
    git br -D asood/pom_eg2
    git co asood/pom_eg2
    git l
}

function co_pom() {
	(set -x; _co_pom)
}