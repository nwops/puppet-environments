# puppet-environments
A example repo of environments.yaml to use with r10k yaml environment feature



## Promote script
Example script to help automate promotion of versions to environments.

```shell
./promote.sh

Welcome to the auto promote script, to get started please specify a version to promote:
If you do not see your version, the tag in the control repo must be created first

1) v0.1.0
#? 1
selected version v0.1.0
Select an environment to promote v0.1.0 to:
1) production	       3) dev1_development   5) dev2_development   7) dev3_development	 9) dev4_development  11) dev5_development
2) dev1_acceptance     4) dev2_acceptance    6) dev3_acceptance	   8) dev4_acceptance	10) dev5_acceptance
#? 2

Promote v0.1.0 to dev1_acceptance? [Y/n] y
[promote-v0.1.0-dev2_acceptance 42eca26] Promoting version v0.1.0 to environment dev1_acceptance
 1 file changed, 1 insertion(+), 1 deletion(-)
If you are ready to push run: git push origin promote-v0.1.0-dev1_acceptance

```
