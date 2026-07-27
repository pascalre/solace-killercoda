until docker inspect solace >/dev/null 2>&1; do sleep 2; done

echo "Waiting for Solace to be ready..."
