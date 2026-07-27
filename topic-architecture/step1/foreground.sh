until docker inspect solace >/dev/null 2>&1; do
  sleep 1
done

docker logs solace -f