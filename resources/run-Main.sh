if [[ -z "${SRVTYPE}" ]]; then
	echo "SRVTYPE is not setted"
	exit 1
fi

if [ "${SRVTYPE}" is "pmmp" ]; then
	sh /minecraft/resources/run-PMMP.sh
	
elif [ "${SRVTYPE}" is "beof" ]; then
	sh /minecraft/resources/run-BEOF.sh

elif [ "${SRVTYPE}" is "cuberite" ]; then
	sh /minecraft/resources/run-CUBE.sh

elif [ "${SRVTYPE}" is "mcpc" ]; then
	sh /minecraft/resources/run-MCPC.sh

elif [ "${SRVTYPE}" is "spigot" ]; then
	sh /minecraft/resources/run-SPIG.sh

else
  echo 'Invalid SRVTYPE!' >&2
  exit 1
fi