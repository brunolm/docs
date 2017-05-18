function c { docker-compose $args }
function cb { docker-compose build $args }
function cup { docker-compose up $args }
function cr { docker-compose run --service-ports --rm $args }
function crl { docker-compose run --service-ports --rm local $args }
function crd { docker-compose run --service-ports --rm develop $args }
function crb { docker-compose run --service-ports --rm build $args }
function crt { docker-compose run --rm test $args }
function crp { docker-compose run --rm provision $args }
function crprod { docker-compose run --rm production $args }
function crci { docker-compose run --rm ci $args }
function cru { docker-compose run --rm update $args }
function cps { docker-compose ps $args }
function clogs { docker-compose logs $args }

function cinstall {
  $projects = Get-ChildItem -Directory

  for ($i = 0; $i -lt $projects.Count; $i++) {
    $project = $projects[$i]

    cd $project.Name
    docker-compose run -d --rm test ONVAULT npm i
    cd ..
  }
}

function cbuild() {
}

function docker-cleanup() {
  docker run -v /var/run/docker.sock:/var/run/docker.sock -v /var/lib/docker:/var/lib/docker --rm martin/docker-cleanup-volumes #--dry-run
}

function docker-reset {
  docker stop $(docker ps -q)
  docker rm $(docker ps -aq)
}

function docker-reset-force() {
  docker rm -f $(docker ps -aq)
}

function docker-proxy {
  docker run --privileged=true -d --name dockito-proxy -v /data/dockito-proxy/certs:/etc/nginx/certs -v /var/run/docker.sock:/tmp/docker.sock -p 80:80 -p 443:443 dockito/proxy:latest
}

function docker-vault {
  $sshfolder = "${env:HomeDrive}${env:HomePath}\.ssh\bravi"
  docker run -d --name dockito-vault -p 14242:3000 -v ${sshfolder}:/vault/.ssh dockito/vault
}

function docker-etcd2 {
  docker run -d -ti --name etcd2 -p 4001:4001 -p 2379:2379 quay.io/coreos/etcd:v2.1.2 -name devbox -advertise-client-urls "http://10.0.75.2:2379,http://10.0.75.2:4001" -listen-client-urls "http://0.0.0.0:2379,http://0.0.0.0:4001" -debug
}

function docker-up {
  docker-reset
  docker-proxy
  docker-vault
  docker-etcd2
}
function dup() {
  docker-up
}

function docker-up-force() {
  docker-reset-force
  docker-up
}
function dup-force() {
  docker-up-force
}
function dupf { docker-up-force }

function dreset() {
  docker-reset
}

function dreset-force() {
  docker-reset-force
}

function dps() {
  $NAME = $args[0]

  if ($NAME -and $NAME.ToString().StartsWith("-")) {
    $NAME = ""
    $PARAMS = $args
  }
  else {
    $PARAMS = $args | select -Skip 1
  }

  if ($PARAMS -contains "-a") {
    docker ps -a --filter "name=$NAME" --format 'table {{.ID}}\t{{.Names}}\t{{.Status}}\t{{.Ports}}'
  }
  elseif ($PARAMS -contains "-e") {
   docker ps --filter "status=exited" --filter "name=$NAME" --format 'table {{.ID}}\t{{.Names}}\t{{.Status}}\t{{.Ports}}'
  }
  else {
    docker ps --filter "status=running" --filter "name=$NAME" --format 'table {{.ID}}\t{{.Names}}\t{{.Status}}\t{{.Ports}}'
  }
}
function dpsi() {
  docker ps --filter "name=$args" --filter status=running --format '{{.ID}} {{.Names}} ---> {{.Status}}\n  {{.Image}}\n  {{.Mounts}}\n  {{.Command}}\n  {{.Ports}}\n'
}

function dps-exited() {
  dps $args -e
}

function dps-all() {
  dps $args -a
}

function dbash() {
  $NAME = $args[0]

  echo ""
  docker ps -a --filter "name=$NAME" --format "{{.Names}}\t{{.ID}}" | Sort-Object -Descending | Select-Object -first 1
  docker exec -it $(docker ps -q --filter "name=$NAME" | Sort-Object -Descending | Select-Object -first 1) bash
}

function dlogs() {
  $NAME = $args[0]
  $PARAMS = $args | select -Skip 1

  echo ""
  docker ps -a --filter "name=$NAME" --format "{{.Names}}\t{{.ID}}" | Sort-Object -Descending | Select-Object -first 1
  docker logs $PARAMS $(docker ps -aq --filter "name=$NAME" | Sort-Object -Descending | Select-Object -first 1)
}

function dstart() {
  $NAME = $args[0]

  docker start $(docker ps -aq --filter "name=$NAME" | Sort-Object -Descending | Select-Object -first 1)
}

function drestart() {
  $NAME = $args[0]

  docker restart $(docker ps -aq --filter "name=$NAME" | Sort-Object -Descending | Select-Object -first 1)
}

function dstop() {
  $NAME = $args[0]

  docker stop $(docker ps -aq --filter "name=$NAME" | Sort-Object -Descending | Select-Object -first 1)
}

function dre() {
  docker rm -f $(docker ps -q --filter status=exited)
}
