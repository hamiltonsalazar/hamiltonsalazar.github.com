// Instalación con la documentación y configuración incial

// Obtener infomración del motor
curl http://admin:password@127.0.0.1:5984

curl http://epi:1234@127.0.0.1:5984

{
  "couchdb": "Welcome",
  "version": "3.0.0",
  "git_sha": "83bdcf693",
  "uuid": "56f16e7c93ff4a2dc20eb6acc7000b71",
  "features": [
    "access-ready",
    "partitioned",
    "pluggable-storage-engines",
    "reshard",
    "scheduler"
  ],
  "vendor": {
    "name": "The Apache Software Foundation"
  }
}



 // Crear base de datos
 curl -X PUT http://user:pass@127.0.0.1:5984/demo

 curl -X PUT http://epi:1234@127.0.0.1:5984/demo

{
    "ok":true
}



// Obtener información de una base de datos

curl -X GET http://user:pass@127.0.0.1:5984/demo

curl -X GET http://epi:1234@127.0.0.1:5984/demo

{
    "compact_running" : false,
    "doc_count" : 0,
    "db_name" : "demo",
    "purge_seq" : 0,
    "committed_update_seq" : 0,
    "doc_del_count" : 0,
    "disk_format_version" : 5,
    "update_seq" : 0,
    "instance_start_time" : "0",
    "disk_size" : 79
}



// Crear un documento simple
curl -H 'Content-Type: application/json' \
            -X POST http://user:pass@127.0.0.1:5984/demo \
            -d '{"company": "Example, Inc."}'

curl -H "Content-Type: application/json" -X POST http://epi:1234@127.0.0.1:5984/demo -d "{\"company\": \"Example, Inc.\"}"

{
    "ok":true,
    "id":"8324f5bbc5f7a7531fa074350300001f",
    "rev":"1-b14c811bf485b30b70aab77810769d00"
}



// Visualizar un documento específico
curl -X GET http://user:pass@127.0.0.1:5984/demo/ObjectId

curl -X GET http://epi:1234@127.0.0.1:5984/demo/8324f5bbc5f7a7531fa074350300001f

{
    "_id":"8324f5bbc5f7a7531fa074350300001f",
    "_rev":"1-b14c811bf485b30b70aab77810769d00","company":"Example, Inc."
}



// Verificar el usuario y contraseña
curl http://admin:password@127.0.0.1:5984/_up

curl http://epi:1234@127.0.0.1:5984/_up

{
    "status":"ok",
    "seeds":{}
}



// Crear un usuario administrador
HOST="http://admin:password@127.0.0.1:5984"
NODENAME="_local"
curl -X PUT $HOST/_node/$NODENAME/_config/admins/anna -d '"secret"'
""

curl -X PUT http://epi:1234@127.0.0.1:5984/_node/_local/_config/admins/anna -d "\"secret\"" ""

"-pbkdf2-d5c68aa4c2efb42b96f439c0f0993ba7cdffeb49,0425691b9976188243e3a400dc1824f2,10"
curl: (3) <url> malformed



// Verificar el crear bases sin credenciales
HOST="http://127.0.0.1:5984"
curl -X PUT $HOST/somedatabase

curl -X PUT http://127.0.0.1:5984/somedatabase

{
    "error":"unauthorized",
    "reason":"You are not a server admin."
}



// Verificar el crear bases con credenciales correctas
HOST="http://anna:secret@127.0.0.1:5984"
curl -X PUT $HOST/somedatabase

curl -X PUT http://anna:secret@127.0.0.1:5984/somedatabase

{
    "ok":true
}



// Solicitud HTTP que parezca que la generó un formulario HTML
HOST="http://127.0.0.1:5984"
curl -vX POST $HOST/_session \
       -H 'Content-Type:application/x-www-form-urlencoded' \
       -d 'name=anna&password=secret'

curl -vX POST http://127.0.0.1:5984/_session -H "Content-Type:application/x-www-form-urlencoded" -d "name=anna&password=secret"

Note: Unnecessary use of -X or --request, POST is already inferred.
*   Trying 127.0.0.1...
* TCP_NODELAY set
* Connected to 127.0.0.1 (127.0.0.1) port 5984 (#0)
> POST /_session HTTP/1.1
> Host: 127.0.0.1:5984
> User-Agent: curl/7.55.1
> Accept: */*
> Content-Type:application/x-www-form-urlencoded
> Content-Length: 25
>
* upload completely sent off: 25 out of 25 bytes
< HTTP/1.1 200 OK
< Cache-Control: must-revalidate
< Content-Length: 45
< Content-Type: application/json
< Date: Tue, 26 May 2020 04:10:34 GMT
< Server: CouchDB/3.0.0 (Erlang OTP/20)
< Set-Cookie: AuthSession=YW5uYTo1RUNDOTZCQjqPaUPDCq4fAUSCyUMnRpf8U7aMsg; Version=1; Expires=Tue, 26-May-2020 04:20:35 GMT; Max-Age=600; Path=/; HttpOnly
<
{"ok":true,"name":"anna","roles":["_admin"]}
* Connection #0 to host 127.0.0.1 left intact



// Crear un nuevo usuario miembro
curl -X PUT http://localhost:5984/_users/org.couchdb.user:jan \
     -H "Accept: application/json" \
     -H "Content-Type: application/json" \
     -d '{"name": "jan", "password": "apple", "roles": [], "type": "user"}'

curl -X PUT http://anna:secret@localhost:5984/_users/org.couchdb.user:jan -H "Accept: application/json" -H "Content-Type: application/json" -d "{\"name\": \"jan\", \"password\": \"apple\", \"roles\": [], \"type\": \"user\"}"

{
    "ok":true,
    "id":"org.couchdb.user:jan",
    "rev":"1-8bc9decfd9533742cfab8968319f6d5d"
}




// Iniciar sesión con el usuario crado
curl -X POST http://localhost:5984/_session -d 'name=jan&password=apple'

curl -X POST http://localhost:5984/_session -d "name=jan&password=apple"

{
    "ok":true,
    "name":"jan",
    "roles":[]
}


curl http://jan:apple@127.0.0.1:5984/_up

{
    "status":"ok",
    "seeds":{}
}

// En caso de ser incorrecto 
{
    "error":"unauthorized",
    "reason":"Name or password is incorrect."
}




// Cambiar contraseña, primero obtenemos información del usuario
curl -X GET http://localhost:5984/_users/org.couchdb.user:jan

curl -X GET http://anna:secret@localhost:5984/_users/org.couchdb.user:jan

{
    "_id":"org.couchdb.user:jan",
    "_rev":"1-8bc9decfd9533742cfab8968319f6d5d",
    "name":"jan",
    "roles":[],
    "type":"user",
    "password_scheme":"pbkdf2",
    "iterations":10,
    "derived_key":"e2b29f2edf7464fcde84400ce8381d39e99df0fc",
    "salt":"15f8f3099f1f93984c566c74be1a13a8"
}

// Ahora editamos la información de este
curl -X PUT http://localhost:5984/_users/org.couchdb.user:jan \
     -H "Accept: application/json" \
     -H "Content-Type: application/json" \
     -H "If-Match: 1-e0ebfb84005b920488fc7a8cc5470cc0" \
     -d '{"name":"jan", "roles":[], "type":"user", "password":"orange"}'

curl -X PUT http://anna:secret@localhost:5984/_users/org.couchdb.user:jan -H "Accept: application/json" -H "Content-Type: application/json" -H "If-Match: 1-8bc9decfd9533742cfab8968319f6d5d" -d "{\"name\":\"jan\", \"roles\":[], \"type\":\"user\", \"password\":\"orange\"}"

{
    "ok":true,
    "id":"org.couchdb.user:jan",
    "rev":"2-724d8f9af35639db6d96504acda22a25"
}

// Ahora verificaremos que el cambio se haya efectuado

curl -X POST http://localhost:5984/_session -d "name=jan&password=apple"

{
    "error":"unauthorized",
    "reason":"Name or password is incorrect."
}

curl -X POST http://localhost:5984/_session -d "name=jan&password=orange"

{"ok":true,"name":"jan","roles":[]}




// Información publica de usuarios
// Si solicita un documento de un usuario y no es administrador o propietario del documento, CouchDB responderá con:
curl http://localhost:5984/_users/org.couchdb.user:robert

{"error":"unauthorized","reason":"You are not authorized to access this db."}

// Si solicita un documento de un usuario que no existe 
curl http://anna:secret@localhost:5984/_users/org.couchdb.user:robert

{"error":"not_found","reason":"missing"}

// set [couchdb] users_db_security_editable = true in local.ini en Windows por alguna razón debemos hacerlo directamente en Fauxton 
// cambiamos la seguirdad de _users
curl foo:bar@localhost:15984/_users/_security -XPUT -d '{}'

curl -X PUT http://anna:secret@localhost:5984/_users/_security -d "{}"

// Compartir el campo name como público con el usuario administrador (epi), este le pedirá la contraseña
curl -X PUT http://localhost:5984/_node/nonode@nohost/_config/couch_httpd_auth/public_fields \
   -H "Content-Type: application/json" \
   -d '"name"' \
   -u admin

curl -X PUT http://localhost:5984/_node/couchdb@localhost/_config/couch_httpd_auth/public_fields -H "Content-Type: application/json" -d "\"name\"" -u epi

""

// Ahora verificamos el usuario
curl http://localhost:5984/_users/org.couchdb.user:jan

{
    "_id":"org.couchdb.user:jan",
    "_rev":"8-3235ca0275da2672932135da6de67d49",
    "name":"jan"
}



// Authorization (members y admins)
// Cuando se crea una BD no hay members o admins. Ahora cambiaremos los permisos por defecto, para ello creamos un documento _security el BD
curl -X PUT http://localhost:5984/mydatabase/_security \
     -u anna:secret \
     -H "Content-Type: application/json" \
     -d '{"admins": { "names": [], "roles": [] }, "members": { "names": ["jan"], "roles": [] } }'

curl -X PUT http://localhost:5984/demo/_security -u anna:secret -H "Content-Type: application/json" -d "{\"admins\": { \"names\": [], \"roles\": [] }, \"members\": { \"names\": [\"jan\"], \"roles\": [] } }"

{"ok":true}

// Si consultamos la BD estará protegida contra lecturas y escrituras
curl http://localhost:5984/mydatabase/

curl http://localhost:5984/demo/

{"error":"unauthorized","reason":"You are not authorized to access this db."}

// Entontonces consultaremos con el usuario jan

curl -u jan:apple http://localhost:5984/mydatabase/

curl -u jan:orange http://localhost:5984/demo/

{
    "db_name":"demo",
    "purge_seq":"0-g1AAAABXeJzLYWBgYMpgTmEQTM4vTc5ISXLIyU9OzMnILy7JAUnlsQBJhgYg9R8IshIZ8KhNZEiqhyjKAgBm5Rxs",
    "update_seq":"3-g1AAAABXeJzLYWBgYMpgTmEQTM4vTc5ISXLIyU9OzMnILy7JAUnlsQBJhgYg9R8IshLxqU1kSKoHK2LMAgBnNRxv",
    "sizes":{
        "file":29020,
        "external":27,
        "active":328
    },
    "props":{},
    "doc_del_count":0,
    "doc_count":1,
    "disk_format_version":8,
    "compact_running":false,
    "cluster":{
        "q":2,
        "n":1,
        "w":1,
        "r":1
    },
    "instance_start_time":"0"
}




// Si queremos que "jan" cree documentos  de diseño debemos asignarle un rol de admin a "jan", pero hacerlo usuario por usuario es tedioso, por lo que se recomienda crear un rol de administrador de BD y asignarle ese rol a "jan", sin embargo debemos dejar un members o admind para que la DB no sea pública. 
curl -X PUT http://localhost:5984/mydatabase/_security \
     -u anna:secret \
     -H "Content-Type: application/json" \
     -d '{"admins": { "names": [], "roles": ["mydatabase_admin"] }, "members": { "names": [], "roles": [] } }'

curl -X PUT http://localhost:5984/demo/_security -u anna:secret -H "Content-Type: application/json" -d "{\"admins\": { \"names\": [], \"roles\": [\"demo_admin\"] }, \"members\": { \"names\": [\"anna\"], \"roles\": [] } }"

{"ok":true}

// Ahora se le asignaremos el rol a Jan, para ello traeremos primero su información
curl -X GET http://anna:secret@localhost:5984/_users/org.couchdb.user:jan  

{"_id":"org.couchdb.user:jan","_rev":"4-243a906e8d80be87fce288be0335157c","name":"jan","roles":[],"type":"user","password_scheme":"pbkdf2","iterations":10,"derived_key":"e04b636fcf54253af088ac4eb8073e6db635a2f4","salt":"c6a0391add4b1bcd502ad661c1bfd653"}

// Luego editaremos esto y asignamos el rol
curl -X PUT http://anna:secret@localhost:5984/_users/org.couchdb.user:jan -H "Accept: application/json" -H "Content-Type: application/json" -H "If-Match: 4-243a906e8d80be87fce288be0335157c" -d "{\"name\":\"jan\", \"roles\":[\"demo_admin\"], \"type\":\"user\"}"

{"ok":true,"id":"org.couchdb.user:jan","rev":"5-a18b6133ee7a82d85d2fee6c596808e6"}

curl -X PUT http://anna:secret@localhost:5984/_users/org.couchdb.user:jan -H "Accept: application/json" -H "Content-Type: application/json" -H "If-Match: 7-048ece1cfc5413a43406ca21ba8405b1" -d "{\"name\":\"jan\", \"roles\":[\"demo_admin\"], \"type\":\"user\"}"




// Obtener una vista 
/database/_design/designdocname/_view/viewname

curl -X GET http://anna:secret@localhost:5984/views/_design/myDesignDoc/_view/firstView

{
    "total_rows":3,"offset":0,"rows":[
        {
            "id":"hello-world",
            "key":"2009/01/15 15:52:20",
            "value":"Hello World"
        },
        {
            "id":"biking",
            "key":"2009/01/30 18:04:11",
            "value":"Biking"
        },
        {
            "id":"bought-a-cat",
            "key":"2009/02/17 21:13:39",
            "value":"Bought a Cat"
        }
    ]
}




// Obtener un documento de una view debemos usar %20 para representar el espacio en la busqueda.
/blog/_design/docs/_view/by_date?key="2009/01/30 18:04:11"

curl -X GET "http://anna:secret@localhost:5984/views/_design/myDesignDoc/_view/firstView?key=\"2009/01/30%2018:04:11\""

{"total_rows":3,"offset":1,"rows":[
{"id":"biking","key":"2009/01/30 18:04:11","value":"Biking"}
]}



// Obtener documentos en un rango de fechas
/blog/_design/docs/_view/by_date?startkey="2010/01/01 00:00:00"&endkey="2010/02/00 00:00:00"

curl "http://anna:secret@localhost:5984/views/_design/myDesignDoc/_view/firstView?startkey=\"2010/01/01%2000:00:00\"&endkey=\"2010/02/00%2000:00:00\""

{"total_rows":3,"offset":3,"rows":[

]}



// Como los parametros starkey y endkey solo funcionan con rangos debemos cambiar los campos date de String a un arreglo de int: 

{
    "date": "2009/01/31 00:00:00"
}

{
    "date": [2009, 1, 31, 0, 0, 0]
}



curl -X GET http://anna:secret@localhost:5984/views/_design/myDesignDoc/_view/firstView

{"total_rows":3,"offset":0,"rows":[
{"id":"hello-world","key":[2009,1,15,15,52,20],"value":"Hello World"},
{"id":"bought-a-cat","key":[2009,1,30,18,4,11],"value":"Bought a Cat"},
{"id":"biking","key":[2009,2,17,21,13,39],"value":"Biking"}
]}



// Probamos de nuevo con el rango
/blog/_design/docs/_view/by_date?startkey=[2010, 1, 1, 0, 0, 0]&endkey=[2010, 2, 1, 0, 0, 0]

curl "http://anna:secret@localhost:5984/views/_design/myDesignDoc/_view/firstView?startkey=\[2009,1,1,0,0,0\]&endkey=\[2009,2,1,0,0,0\]"

{"total_rows":3,"offset":0,"rows":[
{"id":"hello-world","key":[2009,1,15,15,52,20],"value":"Hello World"},
{"id":"bought-a-cat","key":[2009,1,30,18,4,11],"value":"Bought a Cat"}
]}


// Podemos invertir los resultados usando el parametro descending=true
curl "http://anna:secret@localhost:5984/views/_design/myDesignDoc/_view/firstView?descending=true"

{"total_rows":3,"offset":0,"rows":[
{"id":"biking","key":[2009,2,17,21,13,39],"value":"Biking"},
{"id":"bought-a-cat","key":[2009,1,30,18,4,11],"value":"Bought a Cat"},
{"id":"hello-world","key":[2009,1,15,15,52,20],"value":"Hello World"}
]}


curl "http://anna:secret@localhost:5984/views/_design/myDesignDoc/_view/firstView?descending=true&startkey=\[2009,2,1,0,0,0\]"

{"total_rows":3,"offset":1,"rows":[
{"id":"bought-a-cat","key":[2009,1,30,18,4,11],"value":"Bought a Cat"},
{"id":"hello-world","key":[2009,1,15,15,52,20],"value":"Hello World"}
]


curl "http://anna:secret@localhost:5984/views/_design/myDesignDoc/_view/firstView?startkey=\[2009,2,1,0,0,0\]&descending=true"









// Ejemolo de vista guiado
curl -X PUT http://localhost:15984/abc

curl -X PUT http://anna:secret@localhost:5984/abc

{"ok":true}



curl -X POST -H "Content-Type:application/json" http://localhost:15984/abc -d '{"_id":"biking","title":"Biking","body":"My biggest hobby is mountainbiking. The other day...","date":"2009/01/30 18:04:11"}'

curl -X POST -H "Content-Type:application/json" http://anna:secret@localhost:5984/abc -d "{\"_id\":\"biking\",\"title\":\"Biking\",\"body\":\"My biggest hobby is mountainbiking. The other day...\",\"date\":\"2009/01/30 18:04:11\"}"

{"ok":true,"id":"biking","rev":"1-9e21110dc665c8e0201643aa3ad3aeaf"}



curl -X POST -H "Content-Type:application/json" http://localhost:15984/abc -d '{"_id":"bought-a-cat","title":"Bought a Cat","body":"I went to the the pet store earlier and brought home a little kitty...","date":"2009/02/17 21:13:39"}'

curl -X POST -H "Content-Type:application/json" http://anna:secret@localhost:5984/abc -d "{\"_id\":\"bought-a-cat\",\"title\":\"Bought a Cat\",\"body\":\"I went to the the pet store earlier and brought home a little kitty...\",\"date\":\"2009/02/17 21:13:39\"}"

{"ok":true,"id":"bought-a-cat","rev":"1-ccd0a7e95ade7eb2d29cc02ffa582b30"}



curl -X POST -H "Content-Type:application/json" http://localhost:15984/abc -d '{"_id":"hello-world","title":"Hello World","body":"Well hello and welcome to my new blog...","date":"2009/01/15 15:52:20"}'

curl -X POST -H "Content-Type:application/json" http://anna:secret@localhost:5984/abc -d "{\"_id\":\"hello-world\",\"title\":\"Hello World\",\"body\":\"Well hello and welcome to my new blog...\",\"date\":\"2009/01/15 15:52:20\"}"

{"ok":true,"id":"hello-world","rev":"1-97dd85b06c25328a300f3f4041def370"}



curl http://localhost:15984/abc/_all_docs

curl http://anna:secret@localhost:5984/abc/_all_docs

{"total_rows":3,"offset":0,"rows":[
{"id":"biking","key":"biking","value":{"rev":"1-9e21110dc665c8e0201643aa3ad3aeaf"}},
{"id":"bought-a-cat","key":"bought-a-cat","value":{"rev":"1-ccd0a7e95ade7eb2d29cc02ffa582b30"}},
{"id":"hello-world","key":"hello-world","value":{"rev":"1-97dd85b06c25328a300f3f4041def370"}}
]}



curl -X PUT -H "Content-Type:application/json" http://localhost:15984/abc/_design/docs -d '{"language":"javascript","views": {"by_date":{"map":"function(doc) {if(doc.date && doc.title) { emit(doc.date, doc.title) } };"}}}'

curl -X PUT -H "Content-Type:application/json" http://anna:secret@localhost:5984/abc/_design/docs -d "{\"language\":\"javascript\",\"views\": {\"by_date\":{\"map\":\" function(doc) {if(doc.date ^&^& doc.title) { emit(doc.date, doc.title) } }; \"}}}"

{"ok":true,"id":"_design/docs","rev":"8-f7068a1fac41ee0d259f2a3742902af3"}



curl http://localhost:15984/abc/_design/docs/_view/by_date

curl http://anna:secret@localhost:5984/abc/_design/docs/_view/by_date

{"total_rows":3,"offset":0,"rows":[
{"id":"hello-world","key":"2009/01/15 15:52:20","value":"Hello World"},
{"id":"biking","key":"2009/01/30 18:04:11","value":"Biking"},
{"id":"bought-a-cat","key":"2009/02/17 21:13:39","value":"Bought a Cat"}
]}



curl 'http://localhost:15984/abc/_design/docs/_view/by_date?key="2009/01/30%2018:04:11"'

curl "http://anna:secret@localhost:5984/abc/_design/docs/_view/by_date?key=\"2009/01/30%2018:04:11\""

{"total_rows":3,"offset":1,"rows":[
{"id":"biking","key":"2009/01/30 18:04:11","value":"Biking"}
]}




// 1.3. Databases
// HEAD /{db}

HEAD /test HTTP/1.1
Host: localhost:5984

curl -I http://anna:secret@127.0.0.1:5984/views

curl -X HEAD -I http://anna:secret@127.0.0.1:5984/views

HTTP/1.1 200 OK
Cache-Control: must-revalidate
Content-Length: 441
Content-Type: application/json
Date: Sun, 14 Jun 2020 04:52:36 GMT
Server: CouchDB/3.1.0 (Erlang OTP/20)
X-Couch-Request-ID: 2b3a620a0b
X-CouchDB-Body-Time: 0



// GET /{db}

GET /receipts HTTP/1.1
Accept: application/json
Host: localhost:5984

curl -X GET -v http://anna:secret@127.0.0.1:5984/views -H "Accept: application/json"

curl -v http://anna:secret@127.0.0.1:5984/views

Note: Unnecessary use of -X or --request, GET is already inferred.
*   Trying 127.0.0.1...
* TCP_NODELAY set
* Connected to 127.0.0.1 (127.0.0.1) port 5984 (#0)
* Server auth using Basic with user 'anna'
> GET /views HTTP/1.1
> Host: 127.0.0.1:5984
> Authorization: Basic YW5uYTpzZWNyZXQ=
> User-Agent: curl/7.55.1
> Accept: application/json
>
< HTTP/1.1 200 OK
< Cache-Control: must-revalidate
< Content-Length: 441
< Content-Type: application/json
< Date: Sun, 14 Jun 2020 04:53:42 GMT
< Server: CouchDB/3.1.0 (Erlang OTP/20)
< X-Couch-Request-ID: 5efc055710
< X-CouchDB-Body-Time: 0
<
{
    "db_name":"views",
    "purge_seq":"0-g1AAAABXeJzLYWBgYMpgTmEQTM4vTc5ISXLIyU9OzMnILy7JAUnlsQBJhgYg9R8IshIZ8KhNZEiqhyjKAgBm5Rxs",
    "update_seq":"21-g1AAAABXeJzLYWBgYMpgTmEQTM4vTc5ISXLIyU9OzMnILy7JAUnlsQBJhgYg9R8IshIF8KhNZEiqBytizQIAaV8cgQ",
    "sizes":{
        "file":147865,
        "external":1143,
        "active":8051
    },
    "props":{},
    "doc_del_count":0,
    "doc_count":5,
    "disk_format_version":8,
    "compact_running":false,
    "cluster":{
        "q":2,
        "n":1,
        "w":1,
        "r":1
    },
    "instance_start_time":"0"
}
* Connection #0 to host 127.0.0.1 left intact




// /{db}/_all_docs
//GET /{db}/_all_docs

GET /db/_all_docs HTTP/1.1
Accept: application/json
Host: localhost:5984

curl -vX GET http://anna:secret@127.0.0.1:5984/views/_all_docs -H "Accept: application/json"
curl http://anna:secret@127.0.0.1:5984/views/_all_docs

{"total_rows":5,"offset":0,"rows":[
{
    "id":"9abfe390a2f08acd12d32b9574000427",
    "key":"9abfe390a2f08acd12d32b9574000427",
    "value":{"rev":"1-489bcc14ee01aa513c200547c7c222a1"}
},
{
    "id":"_design/myDesignDoc",
    "key":"_design/myDesignDoc",
    "value":{"rev":"7-a15a33b57d63a674c50a99d4ca5e36eb"}
},
{
    "id":"biking",
    "key":"biking",
    "value":{"rev":"5-0654ef5869a24ff5934a6f2ff95acd83"}
},
{
    "id":"bought-a-cat",
    "key":"bought-a-cat",
    "value":{"rev":"5-ab7a0b93b5eed69fe14700de029043c0"}
},
{
    "id":"hello-world",
    "key":"hello-world",
    "value":{"rev":"3-99f393b7e81e8df5ed77e9fdd18d019d"}
}
]}




// POST /{db}/_all_docs

POST /db/_all_docs HTTP/1.1
Accept: application/json
Content-Length: 70
Content-Type: application/json
Host: localhost:5984
{
    "keys" : [
        "Zingylemontart",
        "Yogurtraita"
    ]
}

curl -H "Accept: application/json" -H "Content-Type: application/json" -X POST http://epi:1234@127.0.0.1:5984/views/_all_docs -d "{\"keys\":[\"biking\",\"bought-a-cat\"]}"

{
    "total_rows":5,
    "offset":null,"rows":[
        {
            "id":"biking",
            "key":"biking",
            "value":{
                "rev":"5-0654ef5869a24ff5934a6f2ff95acd83"
            }
        },
        {
            "id":"bought-a-cat",
            "key":"bought-a-cat",
            "value":{
                "rev":"5-ab7a0b93b5eed69fe14700de029043c0"
            }
        }
    ]
}



// /{db}/_design_docs
// GET /{db}/_design_docs

GET /db/_design_docs HTTP/1.1
Accept: application/json
Host: localhost:5984

curl -vX GET http://anna:secret@127.0.0.1:5984/views/_design_docs -H "Accept: application/json"
curl http://anna:secret@127.0.0.1:5984/views/_design_docs

{
    "total_rows":1,"offset":1,"rows":[
        {
            "id":"_design/myDesignDoc",
            "key":"_design/myDesignDoc",
            "value":{
                "rev":"7-a15a33b57d63a674c50a99d4ca5e36eb"
            }
        }
    ]
}



// POST /{db}/_design_docs

POST /db/_all_docs HTTP/1.1
Accept: application/json
Content-Length: 70
Content-Type: application/json
Host: localhost:5984
{
    "keys" : [
        "_design/ddoc02",
        "_design/ddoc05"
    ]
}

curl -X POST http://anna:secret@127.0.0.1:5984/views/_all_docs -H "Accept: application/json" -H "Content-Type: application/json" -d "{    \"keys\" : [        \"_design/doc2\",        \"_design/doc3\"    ]}"

{
    "total_rows":8,
    "offset":null,
    "rows":[
        {
            "id":"_design/doc2",
            "key":"_design/doc2",
            "value":{"rev":"1-8d361a23b4cb8e213f0868ea3d2742c2"}
        },
        {
            "id":"_design/doc3",
            "key":"_design/doc3",
            "value":{"rev":"1-8d361a23b4cb8e213f0868ea3d2742c2"}
        }
    ]
}



// POST /{db}/_all_docs/queries

POST /db/_all_docs/queries HTTP/1.1
Content-Type: application/json
Accept: application/json
Host: localhost:5984
{
    "queries": [
        {
            "keys": [
                "meatballs",
                "spaghetti"
            ]
        },
        {
            "limit": 3,
            "skip": 2
        }
    ]
}

curl -X POST http://anna:secret@127.0.0.1:5984/views/_all_docs/queries -H "Accept: application/json" -H "Content-Type: application/json" -d "{    \"queries\": [{            \"keys\": [\"biking\",\"bought-a-cat\"]        },        {\"limit\": 3,\"skip\": 2}    ]}"

{
    "results":[
        {
            "total_rows":8,
            "offset":null,
            "rows":[
                {
                    "id":"biking",
                    "key":"biking",
                    "value":{
                        "rev":"5-0654ef5869a24ff5934a6f2ff95acd83"
                    }
                },
                {
                    "id":"bought-a-cat",
                    "key":"bought-a-cat",
                    "value":{
                        "rev":"5-ab7a0b93b5eed69fe14700de029043c0"
                    }
                }
            ]
        },
        {
            "total_rows":8,
            "offset":1,
            "rows":[
                {
                    "id":"_design/doc2",
                    "key":"_design/doc2",
                    "value":{"rev":"1-8d361a23b4cb8e213f0868ea3d2742c2"}
                },
                {
                    "id":"_design/doc3",
                    "key":"_design/doc3",
                    "value":{"rev":"1-8d361a23b4cb8e213f0868ea3d2742c2"}
                },
                {
                    "id":"_design/myDesignDoc",
                    "key":"_design/myDesignDoc",
                    "value":{"rev":"7-a15a33b57d63a674c50a99d4ca5e36eb"}
                }
            ]
        }
    ]
}



// POST /{db}/_bulk_get

POST /db/_bulk_get HTTP/1.1
Accept: application/json
Content-Type:application/json
Host: localhost:5984
{
    "docs": [
        {
            "id": "foo"
            "rev": "4-753875d51501a6b1883a9d62b4d33f91",
        },
        {
            "id": "foo"
            "rev": "1-4a7e4ae49c4366eaed8edeaea8f784ad",
        },
        {
            "id": "bar",
        }
        {
            "id": "baz",
        }
    ]
}

curl -X POST http://anna:secret@127.0.0.1:5984/views/_bulk_get -H "Accept: application/json" -H "Content-Type: application/json" -d "{\"docs\": [{\"id\": \"biking\", \"rev\": \"5-0654ef5869a24ff5934a6f2ff95acd83\"},{\"id\": \"bought-a-cat\", \"rev\": \"5-ab7a0b93b5eed69fe14700de029043c0\" }, {\"id\": \"4d09da4324f9677d997396179c00b05f\"}    ]}"

{
    "results": [
        {
            "id": "biking",
            "docs": [
                {
                    "ok":{
                        "_id":"biking",
                        "_rev":"5-0654ef5869a24ff5934a6f2ff95acd83",
                        "title":"Biking",
                        "body":"My biggest hobby is mountainbiking. The other day...",
                        "tags":["cool","freak","plankton"],
                        "date":[2009,2,17,21,13,39],
                        "mime-type":"image/png"
                    }
                }
            ]
        },
        {
            "id": "bought-a-cat", 
            "docs": [
                {
                    "ok":{
                        "_id":"bought-a-cat",
                        "_rev":"5-ab7a0b93b5eed69fe14700de029043c0",
                        "title":"Bought a Cat",
                        "body":"I went to the the pet store earlier and brought home a little kitty...",
                        "date":[2009,1,30,18,4,11],
                        "mime-type":"/images/jpg/22"
                    }
                }
            ]
        },
        {
            "id": "4d09da4324f9677d997396179c00b05f", 
            "docs": [
                {
                    "ok":{
                        "_id":"4d09da4324f9677d997396179c00b05f",
                        "_rev":"1-967a00dff5e02add41819138abb3284d"
                    }
                }
            ]
        }
    ]
}             

POST /db/_bulk_get HTTP/1.1
Accept: application/json
Content-Type:application/json
Host: localhost:5984
{
    "docs": [
        {
            "id": "a"
        }
    ]
}

curl -X POST http://anna:secret@127.0.0.1:5984/views/_bulk_get -H "Accept: application/json" -H "Content-Type: application/json" -d "{    \"docs\": [        {            \"id\": \"biking\"        }    ]}"

{
    "results": [
        {
            "id": "biking", 
            "docs": [
                {
                    "ok":{
                        "_id":"biking",
                        "_rev":"6-bc12b17bac4bd091978341a29fd732da",
                        "title":"Biking","body":"My biggest hobby is mountainbiking. The other day...",
                        "tags":["cool","freak","plankton"],
                        "date":[2009,2,17,21,13,39],
                        "mime-type":"image/png",
                        "update":"si"
                    }
                }
            ]
        }
    ]
}



// /{db}/_bulk_docs

POST /db/_bulk_docs HTTP/1.1
Accept: application/json
Content-Length: 109
Content-Type:application/json
Host: localhost:5984
{
    "docs": [
        {
            "_id": "FishStew"
        },
        {
            "_id": "LambStew",
            "_rev": "2-0786321986194c92dd3b57dfbfc741ce",
            "_deleted": true
        }
    ]
}

curl -X POST http://anna:secret@127.0.0.1:5984/views/_bulk_docs -H "Accept: application/json" -H "Content-Type: application/json" -d "{\"docs\": [{\"_id\": \"4d09da4324f9677d997396179c00b05f\",  \"_rev\": \"5-e674309c0d998b6022a63ac181e363a5\", \"fieldEditable\": \"Second version\"},        {            \"_id\": \"4d09da4324f9677d997396179c01f986\",            \"_rev\": \"1-eb3cb01ca72e1ee5254e3cf0e39dca7a\",            \"_deleted\": true        }    ]}"

[
    {
        "ok":true,
        "id":"4d09da4324f9677d997396179c00b05f",
        "rev":"6-e6a100b8c13f9bfae31e0d1e6a350795"
    },
    {
        "ok":true,
        "id":"4d09da4324f9677d997396179c01f986",
        "rev":"2-e23c3416e451701a1c3730b8e0abb56e"
    }
]



// Insertar en masa

POST /source/_bulk_docs HTTP/1.1
Accept: application/json
Content-Length: 323
Content-Type: application/json
Host: localhost:5984
{
    "docs": [
        {
            "_id": "FishStew",
            "servings": 4,
            "subtitle": "Delicious with freshly baked bread",
            "title": "FishStew"
        },
        {
            "_id": "LambStew",
            "servings": 6,
            "subtitle": "Serve with a whole meal scone topping",
            "title": "LambStew"
        },
        {
            "servings": 8,
            "subtitle": "Hand-made dumplings make a great accompaniment",
            "title": "BeefStew"
        }
    ]
}

curl -X POST http://anna:secret@127.0.0.1:5984/views/_bulk_docs -H "Accept: application/json" -H "Content-Type: application/json" -d "{    \"docs\": [        {            \"_id\": \"FishStew\",            \"servings\": 4,            \"subtitle\": \"Delicious with freshly baked bread\",            \"title\": \"FishStew\"        },        {            \"_id\": \"LambStew\",            \"servings\": 6,            \"subtitle\": \"Serve with a whole meal scone topping\",            \"title\": \"LambStew\"        },        {            \"servings\": 8,            \"subtitle\": \"Hand-made dumplings make a great accompaniment\",            \"title\": \"BeefStew\"        }    ]}"

[
    {
        "ok":true,
        "id":"FishStew",
        "rev":"1-6a466d5dfda05e613ba97bd737829d67"
    },
    {
        "ok":true,
        "id":"LambStew",
        "rev":"1-99b44dff2ed5317052af710a60615474"
    },
    {
        "ok":true,
        "id":"4d09da4324f9677d997396179c021aae",
        "rev":"1-e4602845fc4c99674f50b1d5a804fdfa"
    }
]



// Actualización de documentos en masa

POST /recipes/_bulk_docs HTTP/1.1
Accept: application/json
Content-Length: 464
Content-Type: application/json
Host: localhost:5984
{
    "docs": [
        {
            "_id": "FishStew",
            "_rev": "1-6a466d5dfda05e613ba97bd737829d67",
            "servings": 4,
            "subtitle": "Delicious with freshly baked bread",
            "title": "FishStew"
        },
        {
            "_id": "LambStew",
            "_rev": "1-648f1b989d52b8e43f05aa877092cc7c",
            "servings": 6,
            "subtitle": "Serve with a whole meal scone topping",
            "title": "LambStew"
        },
        {
            "_id": "BeefStew",
            "_rev": "1-e4602845fc4c99674f50b1d5a804fdfa",
            "servings": 8,
            "subtitle": "Hand-made dumplings make a great accompaniment",
            "title": "BeefStew"
        }
    ]
}

curl -X POST http://anna:secret@127.0.0.1:5984/views/_bulk_docs -H "Accept: application/json" -H "Content-Type: application/json" -d "{    \"docs\": [        {            \"_id\": \"FishStew\",            \"_rev\": \"1-6a466d5dfda05e613ba97bd737829d67\",            \"servings\": 4,            \"subtitle\": \"Delicious with freshly baked bread\",            \"title\": \"FishStew\"        },        {            \"_id\": \"LambStew\",            \"_rev\": \"1-99b44dff2ed5317052af710a60615474\",            \"servings\": 6,            \"subtitle\": \"Serve with a whole meal scone topping\",            \"title\": \"LambStew\"        },        {            \"_id\": \"4d09da4324f9677d997396179c021aae\",            \"_rev\": \"1-e4602845fc4c99674f50b1d5a804fdfa\",            \"servings\": 8,            \"subtitle\": \"Hand-made dumplings make a great accompaniment\",            \"title\": \"BeefStew\"        }    ]}"

[
    {
        "ok":true,
        "id":"FishStew",
        "rev":"2-2bff94179917f1dec7cd7f0209066fb8"
    },
    {
        "ok":true,
        "id":"LambStew",
        "rev":"2-c56e4d6f6432d071e29838bdc9f171e9"
    },
    {
        "ok":true,
        "id":"4d09da4324f9677d997396179c021aae",
        "rev":"2-9801936a42f06a16f16c30027980d96f"
    }
]

curl -X POST http://anna:secret@127.0.0.1:5984/views/_bulk_docs -H "Accept: application/json" -H "Content-Type: application/json" -d "{     \"docs\": [        {            \"_id\": \"4d09da4324f9677d997396179c00b05f\",            \"_rev\": \"6-e6a100b8c13f9bfae31e0d1e6a350795\",            \"servings\": 4,            \"subtitle\": \"Delicious with freshly baked bread\",            \"title\": \"FishStew\"        }    ]}"

[
    {
        "ok":true,
        "id":"4d09da4324f9677d997396179c00b05f",
        "rev":"7-4de9d62c0942ce6190466f6695936216"
    }
]

curl -X POST http://anna:secret@127.0.0.1:5984/views/_bulk_docs -H "Accept: application/json" -H "Content-Type: application/json" -d "{     \"docs\": [        {            \"_id\": \"4d09da4324f9677d997396179c00b05f\",            \"_rev\": \"7-4de9d62c0942ce6190466f6695936216\",            \"servings\": 4,            \"subtitle\": \"Delicious with freshly baked bread\",            \"title\": \"FishStew\", \"update\": \"FishStew\"        }    ]}"



// /db/_index

POST /db/_index HTTP/1.1
Content-Type: application/json
Content-Length: 116
Host: localhost:5984
{
    "index": {
        "fields": ["foo"]
    },
    "name" : "foo-index",
    "type" : "json"
}

curl -X POST http://anna:secret@127.0.0.1:5984/views/_index -H "Content-Type: application/json" -d "{    \"index\": {        \"fields\": [\"year\"]    },    \"name\" : \"year-index\",    \"type\" : \"json\"}"

{
    "result":"created",
    "id":"_design/3279fe6d0d893378095bd74c4e53daf27ee5db53",
    "name":"year-index"
}


// /db/_find
// POST /{db}/_find

POST /movies/_find HTTP/1.1
Accept: application/json
Content-Type: application/json
Content-Length: 168
Host: localhost:5984
{
    "selector": {
        "year": {"$gt": 2010}
    },
    "fields": ["_id", "_rev", "year", "title"],
    "sort": [{"year": "asc"}], 
    "limit": 2,
    "skip": 0,
    "execution_stats": true
}

curl -X POST http://anna:secret@127.0.0.1:5984/views/_find -H "Accept: application/json" -H "Content-Type: application/json" -d "{    \"selector\": {        \"year\": {\"$gt\": 2010}    },    \"fields\": [\"_id\", \"_rev\", \"year\", \"title\"], \"sort\": [{\"year\": \"asc\"}],      \"limit\": 2,    \"skip\": 0,    \"execution_stats\": true}"

{
    "docs":[
    {
        "_id":"4d09da4324f9677d997396179c00b05f",
        "_rev":"9-4ca2559289e18e87aadd6d024f8d6d83",
        "year":2011,"title":"FishStew"
    },
    {
        "_id":"FishStew",
        "_rev":"3-bf2f3b558462d40246cd1d162c25d4a1",
        "year":2011,"title":"FishStew"
    }
    ],
    "bookmark": "g2wAAAACaAJkAA5zdGFydGtleV9kb2NpZG0AAAAIRmlzaFN0ZXdoAmQACHN0YXJ0a2V5bAAAAAFiAAAH22pq",
    "execution_stats": {
        "total_keys_examined":0,
        "total_docs_examined":0,
        "total_quorum_docs_examined":0,
        "results_returned":2,
        "execution_time_ms":0.0
    }
}

curl -X POST http://anna:secret@127.0.0.1:5984/views/_find -H "Accept: application/json" -H "Content-Type: application/json" -d "{    \"selector\": {        \"year\": {\"$gt\": 2010}    },    \"fields\": [\"_id\", \"_rev\", \"year\", \"title\"], \"sort\": [{\"year\": \"desc\"}],      \"limit\": 2,    \"skip\": 0,    \"execution_stats\": true}"

{
    "docs":[    
    {
        "_id":"4d09da4324f9677d997396179c021aae",
        "_rev":"3-6791270dc777bf9f260961858e7b569e",
        "year":2019,
        "title":"BeefStew"
    },
    {
        "_id":"LambStew",
        "_rev":"3-8c7a34ed9bfd35cd8c27c5a3734bf4b1",
        "year":2011,
        "title":"LambStew"
    }
    ],
    "bookmark": "g2wAAAACaAJkAA5zdGFydGtleV9kb2NpZG0AAAAgNGQwOWRhNDMyNGY5Njc3ZDk5NzM5NjE3OWMwMjFhYWVoAmQACHN0YXJ0a2V5bAAAAAFiAAAH42pq",
    "execution_stats": {"total_keys_examined":0,"total_docs_examined":0,"total_quorum_docs_examined":0,"results_returned":2,"execution_time_ms":0.0}
}



// Selector with 2 fields

{
    "name": "Paul",
    "location": "Boston"
}

curl -X POST http://anna:secret@127.0.0.1:5984/pruebaproyecto/_find -H "Accept: application/json" -H "Content-Type: application/json" -d "{    \"selector\": {        \"name\": \"Daniela\",        \"lastName\": \"Parra\"    },    \"fields\": [\"_id\", \"_rev\", \"name\", \"lastName\"]}"

{
    "docs":[
        {
            "_id":"1","_rev":"1-9f6dadf76f684b608c56aa87a824c6c5",
            "name":"Daniela","lastName":"Parra"
        },
        {
            "_id":"5186","_rev":"1-7219f9d834d6757ba99bfe36af2b1e3a",
            "name":"Daniela","lastName":"Parra"
        },
        {
            "_id":"671","_rev":"1-d4c4da4fa02bae0ca10f453b80043171",
            "name":"Daniela","lastName":"Parra"
        },
        {
            "_id":"7279","_rev":"1-e70f25a47bdbb6c234bcfdf6ef7ceb8f",
            "name":"Daniela","lastName":"Parra"
        },
        {
            "_id":"7750","_rev":"1-431e40e682a93a0074d94bbaca300782",
            "name":"Daniela","lastName":"Parra"
        },
        {
            "_id":"8172","_rev":"1-343c4ca955b8afe212cfae4211576f5f",
            "name":"Daniela","lastName":"Parra"
        },
        {
            "_id":"9273","_rev":"1-dbcb5c7db0f7e7d103e5c2a8fecd6861",
            "name":"Daniela","lastName":"Parra"
        }
    ],
    "bookmark": "g1AAAAA4eJzLYWBgYMpgSmHgKy5JLCrJTq2MT8lPzkzJBYqzWBqZG4PkOGBycNEsAJp8Dmc",
    "warning": "No matching index found, create an index to optimize query time.\nThe number of documents examined is high in proportion to the number of results returned. Consider adding a more specific index to improve this."
}



// Subfields

{
    "imdb": {
        "rating": 8
    }
}

curl -X POST http://anna:secret@127.0.0.1:5984/pruebaproyecto/_find -H "Accept: application/json" -H "Content-Type: application/json" -d "{    \"selector\":{        \"address\":{            \"department\": \"Cauca\"        }    },    \"fields\": [\"_id\", \"name\", \"address\"]    }"

{
    "docs":[
    {
        "_id":"1",
        "name":"Daniela",
        "address":{"department":"Cauca","city":"Popay├ín","postalCode":647906,"number":5}
    },
    {"_id":"1025","name":"Olivia","address":{"department":"Cauca","postalCode":0,"number":0}},
    {"_id":"1049","name":"Mat├¡as","address":{"department":"Cauca","city":"Popay├ín","postalCode":125133,"number":80}},
    {"_id":"1050","name":"Elizabeth","address":{"department":"Cauca","city":"Popay├ín","postalCode":0,"number":0}},
    {"_id":"1055","name":"Elizabeth","address":{"department":"Cauca","city":"Popay├ín","postalCode":0,"number":0}},
    {"_id":"1072","name":"Scarlett","address":{"department":"Cauca","city":"Popay├ín","postalCode":913715,"number":22}},
    {"_id":"1085","name":"Erick","address":{"department":"Cauca","postalCode":0,"number":0}},
    {"_id":"1118","name":"Mat├¡as","address":{"department":"Cauca","city":"Popay├ín","postalCode":145633,"number":0}},
    {"_id":"1120","name":"Eleanor","address":{"department":"Cauca","city":"Popay├ín","postalCode":0,"number":0}},
    {"_id":"1129","name":"Manuel","address":{"department":"Cauca","city":"Popay├ín","postalCode":624286,"number":97}},
    {"_id":"1149","name":"Ver├│nica","address":{"department":"Cauca","city":"Popay├ín","postalCode":905924,"number":78}},
    {"_id":"1157","name":"Mat├¡as","address":{"department":"Cauca","city":"Popay├ín","postalCode":335754,"number":0}},
    {"_id":"1181","name":"Scarlett","address":{"department":"Cauca","city":"Popay├ín","postalCode":409862,"number":0}},
    {"_id":"1231","name":"Elizabeth","address":{"department":"Cauca","city":"Popay├ín","postalCode":388919,"number":0}},
    {"_id":"1301","name":"Thiago","address":{"department":"Cauca","postalCode":0,"number":0}},
    {"_id":"1318","name":"Pablo","address":{"department":"Cauca","city":"Popay├ín","postalCode":559467,"number":73}},
    {"_id":"1363","name":"├ülvaro","address":{"department":"Cauca","city":"Popay├ín","postalCode":710968,"number":60,"references":["Pasando el puente"]}},
    {"_id":"1400","name":"Eleanor","address":{"department":"Cauca","city":"Popay├ín","postalCode":235232,"number":27}},
    {"_id":"1406","name":"Scarlett","address":{"department":"Cauca","city":"Popay├ín","postalCode":747222,"number":0}},
    {"_id":"1445","name":"Daniela","address":{"department":"Cauca","city":"Popay├ín","postalCode":0,"number":0}},
    {"_id":"1461","name":"Juli├ín","address":{"department":"Cauca","city":"Popay├ín","postalCode":0,"number":0}},
    {"_id":"1515","name":"Charlotte","address":{"department":"Cauca","city":"Popay├ín","postalCode":0,"number":0}},
    {"_id":"1544","name":"Eleanor","address":{"department":"Cauca","postalCode":0,"number":0}},
    {"_id":"1589","name":"Sim├│n","address":{"department":"Cauca","postalCode":0,"number":0}},
    {"_id":"1614","name":"Scarlett","address":{"department":"Cauca","city":"Popay├ín","postalCode":542922,"number":0}}
    ],
    "bookmark": "g1AAAAA4eJzLYWBgYMpgSmHgKy5JLCrJTq2MT8lPzkzJBYqzGJoZmoDkOGBycNEsAJlmDlU",
    "warning": "No matching index found, create an index to optimize query time."
}

{
    "imdb.rating": 8
}

curl -X POST http://anna:secret@127.0.0.1:5984/pruebaproyecto/_find -H "Accept: application/json" -H "Content-Type: application/json" -d "{    \"selector\":{        \"address.department\": \"Cauca\"          },    \"fields\": [\"_id\", \"name\", \"address\"]    }"

{
    "docs":[
    {
        "_id":"1",
        "name":"Daniela",
        "address":{"department":"Cauca","city":"Popay├ín","postalCode":647906,"number":5}
    },
    {"_id":"1025","name":"Olivia","address":{"department":"Cauca","postalCode":0,"number":0}},
    {"_id":"1049","name":"Mat├¡as","address":{"department":"Cauca","city":"Popay├ín","postalCode":125133,"number":80}},
    {"_id":"1050","name":"Elizabeth","address":{"department":"Cauca","city":"Popay├ín","postalCode":0,"number":0}},
    {"_id":"1055","name":"Elizabeth","address":{"department":"Cauca","city":"Popay├ín","postalCode":0,"number":0}},
    {"_id":"1072","name":"Scarlett","address":{"department":"Cauca","city":"Popay├ín","postalCode":913715,"number":22}},
    {"_id":"1085","name":"Erick","address":{"department":"Cauca","postalCode":0,"number":0}},
    {"_id":"1118","name":"Mat├¡as","address":{"department":"Cauca","city":"Popay├ín","postalCode":145633,"number":0}},
    {"_id":"1120","name":"Eleanor","address":{"department":"Cauca","city":"Popay├ín","postalCode":0,"number":0}},
    {"_id":"1129","name":"Manuel","address":{"department":"Cauca","city":"Popay├ín","postalCode":624286,"number":97}},
    {"_id":"1149","name":"Ver├│nica","address":{"department":"Cauca","city":"Popay├ín","postalCode":905924,"number":78}},
    {"_id":"1157","name":"Mat├¡as","address":{"department":"Cauca","city":"Popay├ín","postalCode":335754,"number":0}},
    {"_id":"1181","name":"Scarlett","address":{"department":"Cauca","city":"Popay├ín","postalCode":409862,"number":0}},
    {"_id":"1231","name":"Elizabeth","address":{"department":"Cauca","city":"Popay├ín","postalCode":388919,"number":0}},
    {"_id":"1301","name":"Thiago","address":{"department":"Cauca","postalCode":0,"number":0}},
    {"_id":"1318","name":"Pablo","address":{"department":"Cauca","city":"Popay├ín","postalCode":559467,"number":73}},
    {"_id":"1363","name":"├ülvaro","address":{"department":"Cauca","city":"Popay├ín","postalCode":710968,"number":60,"references":["Pasando el puente"]}},
    {"_id":"1400","name":"Eleanor","address":{"department":"Cauca","city":"Popay├ín","postalCode":235232,"number":27}},
    {"_id":"1406","name":"Scarlett","address":{"department":"Cauca","city":"Popay├ín","postalCode":747222,"number":0}},
    {"_id":"1445","name":"Daniela","address":{"department":"Cauca","city":"Popay├ín","postalCode":0,"number":0}},
    {"_id":"1461","name":"Juli├ín","address":{"department":"Cauca","city":"Popay├ín","postalCode":0,"number":0}},
    {"_id":"1515","name":"Charlotte","address":{"department":"Cauca","city":"Popay├ín","postalCode":0,"number":0}},
    {"_id":"1544","name":"Eleanor","address":{"department":"Cauca","postalCode":0,"number":0}},
    {"_id":"1589","name":"Sim├│n","address":{"department":"Cauca","postalCode":0,"number":0}},
    {"_id":"1614","name":"Scarlett","address":{"department":"Cauca","city":"Popay├ín","postalCode":542922,"number":0}}
    ],
    "bookmark": "g1AAAAA4eJzLYWBgYMpgSmHgKy5JLCrJTq2MT8lPzkzJBYqzGJoZmoDkOGBycNEsAJlmDlU",
    "warning": "No matching index found, create an index to optimize query time."
}



// Operators
// The $and operator

{
  "selector": {
    "$and": [
      {
        "$title": "Total Recall"
      },
      {
        "year": {
          "$in": [1984, 1991]
        }
      }
    ]
  },
  "fields": [
    "year",
    "title",
    "cast"
  ]
}

curl -X POST http://anna:secret@127.0.0.1:5984/pruebaproyecto/_find -H "Accept: application/json" -H "Content-Type: application/json" -d "{  \"selector\": {    \"$and\": [      {        \"name\": \"Daniela\"      },      {        \"age\": {          \"$in\": [37, 40]        }      }    ]  },  \"fields\": [    \"age\",    \"name\",    \"_id\"  ]}"

{
    "docs":[
    {"age":37,"name":"Daniela","_id":"1"},
    {"age":40,"name":"Daniela","_id":"2688"},
    {"age":40,"name":"Daniela","_id":"456"},
    {"age":40,"name":"Daniela","_id":"6004"},
    {"age":37,"name":"Daniela","_id":"7211"},
    {"age":37,"name":"Daniela","_id":"8079"},
    {"age":40,"name":"Daniela","_id":"821"}
    ],
    "bookmark": "g1AAAAA2eJzLYWBgYMpgSmHgKy5JLCrJTq2MT8lPzkzJBYozWxgZgqQ4YFIwwSwAfq4N8Q",
    "warning": "No matching index found, create an index to optimize query time.\nThe number of documents examined is high in proportion to the number of results returned. Consider adding a more specific index to improve this."
}



// A partir de ahora trabajaré con archivos .json enviados como parametro, almacenados en "C:\Users\hamil\OneDrive\Documents\GitHub\hamiltonsalazar.github.com\CouchDB"



// Indexar por edad

curl -X POST http://anna:secret@127.0.0.1:5984/pruebaproyecto/_index -H "Content-Type: application/json" -d @Index0.json

{
    "result":"created",
    "id":"_design/age-index",
    "name":"age-index"
}



// Indexar por name

curl -X POST http://anna:secret@127.0.0.1:5984/pruebaproyecto/_index -H "Content-Type: application/json" -d @Index00.json

{
    "result":"created",
    "id":"_design/name-index",
    "name":"name-index"
}



// The $or operator

{
    "year": 1977,
    "$or": [
        { "director": "George Lucas" },
        { "director": "Steven Spielberg" }
    ]
}

curl -X POST http://anna:secret@127.0.0.1:5984/pruebaproyecto/_find -H "Accept: application/json" -H "Content-Type: application/json" -d @consulta1.json

{
    "docs":[
    {"name":"Mart├¡n","age":29,"_id":"5484"},
    {"name":"Mart├¡n","age":29,"_id":"6731"},
    {"name":"Daniela","age":29,"_id":"7240"},
    {"name":"Daniela","age":29,"_id":"8099"},
    {"name":"Daniela","age":29,"_id":"8172"}
    ],
    "bookmark": "g2wAAAACaAJkAA5zdGFydGtleV9kb2NpZG0AAAAEODE3MmgCZAAIc3RhcnRrZXlrAAEdag",
    "warning": "The number of documents examined is high in proportion to the number of results returned. Consider adding a more specific index to improve this."
}



// Rango a trabajar entre 25 y 30

curl -X POST http://anna:secret@127.0.0.1:5984/pruebaproyecto/_find -H "Accept: application/json" -H "Content-Type: application/json" -d @consulta2.json

{
        "docs":[
    {"name":"Adelaide","age":27,"_id":"1311"},
    {"name":"Adelaide","age":28,"_id":"1656"},
    {"name":"Adelaide","age":28,"_id":"254"},
    {"name":"Adelaide","age":25,"_id":"3630"},
    {"name":"Adelaide","age":25,"_id":"3763"},
    {"name":"Adelaide","age":27,"_id":"408"},
    {"name":"Adelaide","age":27,"_id":"5051"},
    {"name":"Adelaide","age":26,"_id":"5695"},
    {"name":"Adelaide","age":30,"_id":"7166"},
    {"name":"Adelaide","age":28,"_id":"7728"},
    {"name":"Adelaide","age":27,"_id":"9266"},
    {"name":"Adelaide","age":27,"_id":"9297"},
    {"name":"Adeline","age":29,"_id":"1615"},
    {"name":"Adeline","age":28,"_id":"1634"},
    {"name":"Adeline","age":26,"_id":"2370"},
    {"name":"Adeline","age":30,"_id":"2491"},
    {"name":"Adeline","age":30,"_id":"387"},
    {"name":"Adeline","age":30,"_id":"3994"},
    {"name":"Adeline","age":30,"_id":"4353"},
    {"name":"Adeline","age":29,"_id":"4451"},
    {"name":"Adeline","age":27,"_id":"5126"},
    {"name":"Adeline","age":28,"_id":"5529"},
    {"name":"Adeline","age":26,"_id":"5612"},
    {"name":"Adeline","age":29,"_id":"5786"},
    {"name":"Adeline","age":29,"_id":"6361"}
    ],
    "bookmark": "g1AAAABBeJzLYWBgYMpgSmHgKy5JLCrJTq2MT8lPzkzJBYqzmBmbGYLkOGByOUBRRpAUu2NKak5mXmpWFgAjzhEZ"
}



// The $not operator

{
    "year": {
        "$gte": 1900
    },
    "year": {
        "$lte": 1903
    },
    "$not": {
        "year": 1901
    }
}

curl -X POST http://anna:secret@127.0.0.1:5984/pruebaproyecto/_find -H "Accept: application/json" -H "Content-Type: application/json" -d @consulta3.json

{
    "docs":[
    {"_id":"1499","name":"Valent├¡n","age":30},
    {"_id":"1336","name":"Carlos","age":30},
    {"_id":"1298","name":"Gabriel","age":30},
    {"_id":"1274","name":"Evelyn","age":30},
    {"_id":"1261","name":"Olivia","age":30},
    {"_id":"1181","name":"Scarlett","age":30},
    {"_id":"1089","name":"Regina","age":30},
    {"_id":"1025","name":"Olivia","age":30},
    {"_id":"1011","name":"Valent├¡n","age":30},
    {"_id":"9953","name":"Julia","age":28},
    {"_id":"9952","name":"Thiago","age":28},
    {"_id":"9909","name":"Mateo","age":28},
    {"_id":"9877","name":"Evelyn","age":28},
    {"_id":"9866","name":"Juli├ín","age":28},
    {"_id":"9864","name":"Ava","age":28},
    {"_id":"9630","name":"Mat├¡as","age":28},
    {"_id":"9592","name":"Marcos","age":28},
    {"_id":"9557","name":"Samantha","age":28},
    {"_id":"9425","name":"Ava","age":28},
    {"_id":"9420","name":"Manuel","age":28},
    {"_id":"9273","name":"Daniela","age":28},
    {"_id":"9196","name":"Renata","age":28},
    {"_id":"9176","name":"Marcos","age":28},
    {"_id":"9163","name":"Scarlett","age":28},
    {"_id":"916","name":"Erick","age":28}
    ],
    "bookmark": "g2wAAAACaAJkAA5zdGFydGtleV9kb2NpZG0AAAADOTE2aAJkAAhzdGFydGtleWsAARxq"
}



// El $nor operador

{
    "year": {
        "$gte": 1900
    },
    "year": {
        "$lte": 1910
    },
    "$nor": [
        { "year": 1901 },
        { "year": 1905 },
        {  "year": 1907 }
    ]
}

curl -X POST http://anna:secret@127.0.0.1:5984/pruebaproyecto/_find -H "Accept: application/json" -H "Content-Type: application/json" -d @consulta4.json

{
    "docs":[
    {"_id":"9318","name":"Samantha","age":25},
    {"_id":"9321","name":"Elizabeth","age":25},
    {"_id":"9331","name":"Sim├│n","age":25},
    {"_id":"9375","name":"Mateo","age":25},
    {"_id":"9453","name":"Adeline","age":25},
    {"_id":"947","name":"Benjam├¡n","age":25},
    {"_id":"9488","name":"Violet","age":25},
    {"_id":"9490","name":"Carlos","age":25},
    {"_id":"9555","name":"Adri├ín","age":25},
    {"_id":"9580","name":"Gabriel","age":25},
    {"_id":"9587","name":"Mart├¡n","age":25},
    {"_id":"9624","name":"Diego","age":25},
    {"_id":"9703","name":"Mateo","age":25},
    {"_id":"9735","name":"Camila","age":25},
    {"_id":"9880","name":"Gabriel","age":25},
    {"_id":"999","name":"Javier","age":25},
    {"_id":"9995","name":"Valeria","age":25},
    {"_id":"1000","name":"David","age":29},
    {"_id":"101","name":"Paula","age":29},
    {"_id":"1122","name":"Cora","age":29},
    {"_id":"1187","name":"Iv├ín","age":29},
    {"_id":"1229","name":"Valeria","age":29},
    {"_id":"1269","name":"Alice","age":29},
    {"_id":"1284","name":"Valeria","age":29},
    {"_id":"1287","name":"Renata","age":29}
    ],
    "bookmark": "g2wAAAACaAJkAA5zdGFydGtleV9kb2NpZG0AAAAEMTI4N2gCZAAIc3RhcnRrZXlrAAEdag"
}



// Indexar por scores

curl -X POST http://anna:secret@127.0.0.1:5984/pruebaproyecto/_index -H "Content-Type: application/json" -d @Index1.json

{
    "result":"created",
    "id":"_design/77f7006a3a05c6388abfdc745a573bc56a052d4c",
    "name":"scores-index"
}


// The $all operator

{
    "_id": {
        "$gt": null
    },
    "genre": {
        "$all": ["Comedy","Short"]
    }
}

curl -X POST http://anna:secret@127.0.0.1:5984/pruebaproyecto/_find -H "Accept: application/json" -H "Content-Type: application/json" -d @consulta5.json

{
    "docs":[
    {"_id":"2654","name":"Ava","scores":[0,0,6,3,1,4,2,8,7,9]},
    {"_id":"3010","name":"Valent├¡n","scores":[0,1,6,3,8,1,2,5]},
    {"_id":"1423","name":"Mario","scores":[0,1,8,3,6,3,1,3,2]},
    {"_id":"2256","name":"Miguel","scores":[0,1,8,4,3,6,5,2,8,5]},
    {"_id":"6847","name":"Dulce","scores":[0,1,9,2,6,6,8,5,3,7]},
    {"_id":"5003","name":"Ava","scores":[0,3,2,8,2,5,8,1,6,6]},
    {"_id":"5350","name":"Olivia","scores":[0,4,3,2,6,1,9,8,7]},
    {"_id":"3250","name":"Benjam├¡n","scores":[0,5,3,6,1,5,2,7,8]},
    {"_id":"9503","name":"Dante","scores":[0,7,2,6,3,8,3,1]},
    {"_id":"2565","name":"Carlos","scores":[0,8,7,6,1,6,3,9,7,2]},
    {"_id":"2705","name":"Eleanor","scores":[1,6,3,7,7,6,5,8,0,2]},
    {"_id":"7217","name":"Benjam├¡n","scores":[1,8,9,0,6,9,3,4,2,2]},
    {"_id":"4503","name":"Juli├ín","scores":[1,9,6,8,9,3,5,2,0]},
    {"_id":"9387","name":"Mart├¡n","scores":[2,1,0,8,1,6,6,4,3]},
    {"_id":"741","name":"David","scores":[2,2,6,4,9,0,7,1,3,8]},
    {"_id":"101","name":"Paula","scores":[2,6,1,2,3,8,1,0]},
    {"_id":"9779","name":"Luc├¡a","scores":[2,7,1,8,6,0,0,3]},
    {"_id":"8787","name":"Mar├¡a","scores":[2,7,6,3,8,4,0,1,0,3]},
    {"_id":"7735","name":"Regina","scores":[2,8,0,4,1,5,1,3,2,6]},
    {"_id":"4122","name":"David","scores":[2,8,6,3,0,1,7,6,2]},
    {"_id":"9984","name":"Luc├¡a","scores":[2,8,6,9,9,0,9,3,3,1]},
    {"_id":"7692","name":"Lucas","scores":[2,8,7,3,0,9,0,3,6,1]},
    {"_id":"9697","name":"Samantha","scores":[3,0,6,4,1,2,6,8]},
    {"_id":"1505","name":"Isla","scores":[3,0,8,8,6,1,2,9]},
    {"_id":"6320","name":"Erick","scores":[3,5,4,7,0,6,1,8,2]}
    ],
    "bookmark": "g2wAAAACaAJkAA5zdGFydGtleV9kb2NpZG0AAAAENjMyMGgCZAAIc3RhcnRrZXlsAAAAAWsACQMFBAcABgEIAmpq"
}



// El $elemMatch operador

{
    "_id": { "$gt": null },
    "genre": {
        "$elemMatch": {
            "$eq": "Horror"
        }
    }
}

curl -X POST http://anna:secret@127.0.0.1:5984/pruebaproyecto/_find -H "Accept: application/json" -H "Content-Type: application/json" -d @consulta6.json

{
    "docs":[
    {"_id":"1252","name":"Sim├│n","scores":[0,0,2,6,0,5,7,8,3,7]},
    {"_id":"7467","name":"Chloe","scores":[0,0,2,7,9,5,8]},
    {"_id":"4572","name":"Amalia","scores":[0,0,2,8,2,8,7]},
    {"_id":"181","name":"├üngel","scores":[0,0,3,0,5,3,8,9,3]},
    {"_id":"3668","name":"Carlos","scores":[0,0,4,8]},
    {"_id":"2035","name":"Eleanor","scores":[0,0,4,8,0,5,8,7]},
    {"_id":"3714","name":"Nicol├ís","scores":[0,0,5,2,4,8,2,7,9,7]},
    {"_id":"4634","name":"Olivia","scores":[0,0,5,7,8]},
    {"_id":"7497","name":"Thiago","scores":[0,0,5,8,9,9]},
    {"_id":"2654","name":"Ava","scores":[0,0,6,3,1,4,2,8,7,9]},
    {"_id":"8664","name":"Alice","scores":[0,0,6,4,4,7,7,5,8]},
    {"_id":"2810","name":"Eleanor","scores":[0,0,6,6,8,8,2]},
    {"_id":"8368","name":"Marcos","scores":[0,0,7,8,2]},
    {"_id":"3887","name":"├üngel","scores":[0,0,8,2,3,0,4,4]},
    {"_id":"8674","name":"Ava","scores":[0,0,8,3,2,5]},
    {"_id":"3014","name":"Lucy","scores":[0,0,8,3,4]},
    {"_id":"2368","name":"Chloe","scores":[0,0,8,3,8]},
    {"_id":"1495","name":"Jorge","scores":[0,0,8,6,6,4]},
    {"_id":"435","name":"Violet","scores":[0,0,8,7,7,0,7,5,7]},
    {"_id":"8914","name":"Carlos","scores":[0,0,8,8,7,5]},
    {"_id":"5232","name":"Thiago","scores":[0,0,9,3,6,9,3,8,8]},
    {"_id":"6051","name":"Adri├ín","scores":[0,0,9,8,6,1,8,9,0]},
    {"_id":"4957","name":"Isla","scores":[0,0,9,8,6,5,3,9,1,0]},
    {"_id":"3326","name":"Carlos","scores":[0,1,0,0,1,8,9,3,4,9]},
    {"_id":"5463","name":"Mateo","scores":[0,1,0,8]}
    ],
    "bookmark": "g2wAAAACaAJkAA5zdGFydGtleV9kb2NpZG0AAAAENTQ2M2gCZAAIc3RhcnRrZXlsAAAAAWsABAABAAhqag"
}



// Indexar por courses

curl -X POST http://anna:secret@127.0.0.1:5984/pruebaproyecto/_index -H "Content-Type: application/json" -d @Index2.json

{
    "result":"created",
    "id":"_design/courses-index",
    "name":"courses-index"
}




curl -X POST http://anna:secret@127.0.0.1:5984/pruebaproyecto/_find -H "Accept: application/json" -H "Content-Type: application/json" -d @consulta7.json

{
    "docs":[
    {
        "_id":"5682",
        "name":"Benjam├¡n",
        "courses":[
            {"title":"android-kotlin","progress":0,"completed":false,"tutor":{"name":"Codeacademy","link":"codecademy.com"}},
            {"title":"angular-profesional","progress":17,"completed":false,"tutor":{"name":"C├│dgioFacilito","link":"https://codigofacilito.com/"}},
            {"title":"javascript-profesional","progress":59,"completed":false,"tutor":{"name":"C├│dgioFacilito","link":"https://codigofacilito.com/"}},
            {"title":"java-profesional","progress":10,"completed":false,"tutor":{"name":"Codeacademy","link":"codecademy.com"}}
        ]
    },
    {
        "_id":"2885",
        "name":"Sim├│n",
        "courses":[
            {"title":"android-kotlin","progress":1,"completed":false,"tutor":{"name":"Scratch","link":"https://scratch.mit.edu/"}},
            {"title":"javascript-profesional","progress":23,"completed":false,"tutor":{"name":"Codemonkey ","link":"https://www.codemonkey.com/"}},
            {"title":"introduccion-requesitos","progress":71,"completed":false,"tutor":{"name":"Scratch","link":"https://scratch.mit.edu/"}},
            {"title":"python-profesional","progress":69,"completed":false,"tutor":{"name":"Code.org","link":"https://code.org/"}}
        ]
    },
    {
        "_id":"8958",
        "name":"├üngel",
        "courses":[
            {"title":"android-kotlin","progress":2,"completed":false,"tutor":{"name":"Scratch","link":"https://scratch.mit.edu/"}},
            {"title":"frontend-profesional","progress":37,"completed":false,"tutor":{"name":"C├│dgioFacilito","link":"https://codigofacilito.com/"}},
            {"title":"javascript-profesional","progress":4,"completed":false,"tutor":{"name":"Code.org","link":"https://code.org/"}}
        ]
    },
    {"_id":"6228","name":"Pablo","courses":[{"title":"android-kotlin","progress":4,"completed":false,"tutor":{"name":"Codeacademy","link":"codecademy.com"}},{"title":"javascript-profesional","progress":96,"completed":false,"tutor":{"name":"C├│dgioFacilito","link":"https://codigofacilito.com/"}},{"title":"introduccion-requesitos","progress":3,"completed":false,"tutor":{"name":"Scratch","link":"https://scratch.mit.edu/"}},{"title":"javascript-profesional","progress":46,"completed":false,"tutor":{"name":"Codemonkey ","link":"https://www.codemonkey.com/"}}]},
    {"_id":"3015","name":"Paula","courses":[{"title":"android-kotlin","progress":6,"completed":false,"tutor":{"name":"Scratch","link":"https://scratch.mit.edu/"}},{"title":"docker-swarm","progress":73,"completed":false,"tutor":{"name":"Code.org","link":"https://code.org/"}},{"title":"javascript-profesional","progress":14,"completed":false,"tutor":{"name":"Codeacademy","link":"codecademy.com"}},{"title":"swift-introduccion","progress":52,"completed":false,"tutor":{"name":"Scratch","link":"https://scratch.mit.edu/"}},{"title":"flutter-sqlite","progress":44,"completed":false,"tutor":{"name":"C├│dgioFacilito","link":"https://codigofacilito.com/"}}]},
    {"_id":"7679","name":"Adeline","courses":[{"title":"android-kotlin","progress":11,"completed":false,"tutor":{"name":"Codeacademy","link":"codecademy.com"}},{"title":"consumir-apis-javascript","progress":8,"completed":false,"tutor":{"name":"C├│dgioFacilito","link":"https://codigofacilito.com/"}},{"title":"javascript-profesional","progress":40,"completed":false,"tutor":{"name":"Code.org","link":"https://code.org/"}},{"title":"android-profesional","progress":59,"completed":false,"tutor":{"name":"Code.org","link":"https://code.org/"}},{"title":"angular-profesional","progress":20,"completed":false,"tutor":{"name":"Scratch","link":"https://scratch.mit.edu/"}}]},
    {"_id":"464","name":"Ver├│nica","courses":[{"title":"android-kotlin","progress":12,"completed":false,"tutor":{"name":"Code.org","link":"https://code.org/"}},{"title":"javascript-profesional","progress":26,"completed":false,"tutor":{"name":"C├│dgioFacilito","link":"https://codigofacilito.com/"}},{"title":"android-kotlin","progress":71,"completed":false,"tutor":{"name":"Codeacademy","link":"codecademy.com"}},{"title":"introduccion-nginx","progress":88,"completed":false,"tutor":{"name":"Codeacademy","link":"codecademy.com"}}]},
    {"_id":"4637","name":"Sergio","courses":[{"title":"android-kotlin","progress":12,"completed":false,"tutor":{"name":"C├│dgioFacilito","link":"https://codigofacilito.com/"}},{"title":"introduccion-nginx","progress":8,"completed":false,"tutor":{"name":"Scratch","link":"https://scratch.mit.edu/"}},{"title":"introduccion-nginx","progress":63,"completed":false,"tutor":{"name":"Scratch","link":"https://scratch.mit.edu/"}},{"title":"javascript-profesional","progress":72,"completed":false,"tutor":{"name":"Codemonkey ","link":"https://www.codemonkey.com/"}}]},
    {"_id":"6346","name":"Isla","courses":[{"title":"android-kotlin","progress":16,"completed":false,"tutor":{"name":"Codeacademy","link":"codecademy.com"}},{"title":"automatizacion-tareas-python","progress":92,"completed":false,"tutor":{"name":"Codeacademy","link":"codecademy.com"}},{"title":"javascript-profesional","progress":26,"completed":false,"tutor":{"name":"Codeacademy","link":"codecademy.com"}},{"title":"consumir-apis-javascript","progress":1,"completed":false,"tutor":{"name":"Codeacademy","link":"codecademy.com"}},{"title":"consumir-apis-javascript","progress":66,"completed":false,"tutor":{"name":"Codeacademy","link":"codecademy.com"}}]},
    {"_id":"7307","name":"├ülvaro","courses":[{"title":"android-kotlin","progress":21,"completed":false,"tutor":{"name":"C├│dgioFacilito","link":"https://codigofacilito.com/"}},{"title":"introduccion-requesitos","progress":13,"completed":false,"tutor":{"name":"Scratch","link":"https://scratch.mit.edu/"}},{"title":"javascript-profesional","progress":98,"completed":false,"tutor":{"name":"Codemonkey ","link":"https://www.codemonkey.com/"}}]},
    {"_id":"972","name":"Mart├¡n","courses":[{"title":"android-kotlin","progress":23,"completed":false,"tutor":{"name":"C├│dgioFacilito","link":"https://codigofacilito.com/"}},{"title":"javascript-profesional","progress":11,"completed":false,"tutor":{"name":"Codemonkey ","link":"https://www.codemonkey.com/"}}]},
    {"_id":"4367","name":"Diego","courses":[{"title":"android-kotlin","progress":26,"completed":false,"tutor":{"name":"Scratch","link":"https://scratch.mit.edu/"}},{"title":"mongoose","progress":36,"completed":false,"tutor":{"name":"Scratch","link":"https://scratch.mit.edu/"}},{"title":"swift-introduccion","progress":4,"completed":false,"tutor":{"name":"Code.org","link":"https://code.org/"}},{"title":"javascript-profesional","progress":72,"completed":false,"tutor":{"name":"Scratch","link":"https://scratch.mit.edu/"}}]},
    {"_id":"9733","name":"Renata","courses":[{"title":"android-kotlin","progress":29,"completed":false,"tutor":{"name":"Codemonkey ","link":"https://www.codemonkey.com/"}},{"title":"git-profesional","progress":64,"completed":false,"tutor":{"name":"Codeacademy","link":"codecademy.com"}},{"title":"javascript-profesional","progress":91,"completed":false,"tutor":{"name":"Codeacademy","link":"codecademy.com"}},{"title":"javascript-profesional","progress":10,"completed":false,"tutor":{"name":"Codeacademy","link":"codecademy.com"}},{"title":"base-datos-profesional","progress":53,"completed":false,"tutor":{"name":"C├│dgioFacilito","link":"https://codigofacilito.com/"}}]},
    {"_id":"6467","name":"Mat├¡as","courses":[{"title":"android-kotlin","progress":30,"completed":false,"tutor":{"name":"Codeacademy","link":"codecademy.com"}},{"title":"ionic-v5","progress":31,"completed":false,"tutor":{"name":"C├│dgioFacilito","link":"https://codigofacilito.com/"}},{"title":"javascript-profesional","progress":65,"completed":false,"tutor":{"name":"Code.org","link":"https://code.org/"}},{"title":"nosql-moongodb","progress":38,"completed":false,"tutor":{"name":"Codeacademy","link":"codecademy.com"}}]},
    {"_id":"7401","name":"Miguel","courses":[{"title":"android-kotlin","progress":33,"completed":false,"tutor":{"name":"Code.org","link":"https://code.org/"}},{"title":"javascript-profesional","progress":69,"completed":false,"tutor":{"name":"Codeacademy","link":"codecademy.com"}},{"title":"javascript-profesional","progress":18,"completed":false,"tutor":{"name":"Code.org","link":"https://code.org/"}}]},
    {"_id":"2341","name":"Pablo","courses":[{"title":"android-kotlin","progress":34,"completed":false,"tutor":{"name":"Codeacademy","link":"codecademy.com"}},{"title":"javascript-profesional","progress":96,"completed":false,"tutor":{"name":"Scratch","link":"https://scratch.mit.edu/"}},{"title":"android-kotlin","progress":22,"completed":false,"tutor":{"name":"Codemonkey ","link":"https://www.codemonkey.com/"}},{"title":"angular-profesional","progress":42,"completed":false,"tutor":{"name":"C├│dgioFacilito","link":"https://codigofacilito.com/"}}]},
    {"_id":"7395","name":"Lucas","courses":[{"title":"android-kotlin","progress":36,"completed":false,"tutor":{"name":"C├│dgioFacilito","link":"https://codigofacilito.com/"}},{"title":"javascript-profesional","progress":69,"completed":false,"tutor":{"name":"Scratch","link":"https://scratch.mit.edu/"}},{"title":"consumir-apis-javascript","progress":20,"completed":false,"tutor":{"name":"Code.org","link":"https://code.org/"}},{"title":"backend-profesional","progress":50,"completed":false,"tutor":{"name":"Scratch","link":"https://scratch.mit.edu/"}},{"title":"java-profesional","progress":62,"completed":false,"tutor":{"name":"Codeacademy","link":"codecademy.com"}}]},
    {"_id":"7487","name":"Samantha","courses":[{"title":"android-kotlin","progress":37,"completed":false,"tutor":{"name":"Codemonkey ","link":"https://www.codemonkey.com/"}},{"title":"javascript-profesional","progress":34,"completed":false,"tutor":{"name":"Codemonkey ","link":"https://www.codemonkey.com/"}},{"title":"angular-profesional","progress":7,"completed":false,"tutor":{"name":"Code.org","link":"https://code.org/"}},{"title":"android-profesional","progress":22,"completed":false,"tutor":{"name":"Code.org","link":"https://code.org/"}},{"title":"typescript","progress":34,"completed":false,"tutor":{"name":"Code.org","link":"https://code.org/"}}]},
    {"_id":"415","name":"Mar├¡a","courses":[{"title":"android-kotlin","progress":37,"completed":false,"tutor":{"name":"C├│dgioFacilito","link":"https://codigofacilito.com/"}},{"title":"introduccion-nginx","progress":33,"completed":false,"tutor":{"name":"C├│dgioFacilito","link":"https://codigofacilito.com/"}},{"title":"javascript-profesional","progress":33,"completed":false,"tutor":{"name":"Scratch","link":"https://scratch.mit.edu/"}},{"title":"android-kotlin","progress":11,"completed":false,"tutor":{"name":"Codeacademy","link":"codecademy.com"}},{"title":"flutter-sqlite","progress":16,"completed":false,"tutor":{"name":"Scratch","link":"https://scratch.mit.edu/"}}]},
    {"_id":"2028","name":"Mart├¡n","courses":[{"title":"android-kotlin","progress":37,"completed":false,"tutor":{"name":"C├│dgioFacilito","link":"https://codigofacilito.com/"}},{"title":"javascript-profesional","progress":91,"completed":false,"tutor":{"name":"Codeacademy","link":"codecademy.com"}},{"title":"git-profesional","progress":66,"completed":false,"tutor":{"name":"Codemonkey ","link":"https://www.codemonkey.com/"}},{"title":"swift-introduccion","progress":6,"completed":false,"tutor":{"name":"Scratch","link":"https://scratch.mit.edu/"}},{"title":"docker-swarm","progress":89,"completed":false,"tutor":{"name":"Scratch","link":"https://scratch.mit.edu/"}}]},
    {"_id":"8996","name":"Daniel","courses":[{"title":"android-kotlin","progress":40,"completed":false,"tutor":{"name":"Code.org","link":"https://code.org/"}},{"title":"mongoose","progress":60,"completed":false,"tutor":{"name":"Code.org","link":"https://code.org/"}},{"title":"android-profesional","progress":3,"completed":false,"tutor":{"name":"C├│dgioFacilito","link":"https://codigofacilito.com/"}},{"title":"javascript-profesional","progress":11,"completed":false,"tutor":{"name":"C├│dgioFacilito","link":"https://codigofacilito.com/"}}]},
    {"_id":"9611","name":"Chloe","courses":[{"title":"android-kotlin","progress":41,"completed":false,"tutor":{"name":"Codeacademy","link":"codecademy.com"}},{"title":"javascript-profesional","progress":99,"completed":false,"tutor":{"name":"Codeacademy","link":"codecademy.com"}}]},
    {"_id":"6746","name":"Regina","courses":[{"title":"android-kotlin","progress":43,"completed":false,"tutor":{"name":"Code.org","link":"https://code.org/"}},{"title":"javascript-profesional","progress":19,"completed":false,"tutor":{"name":"Codemonkey ","link":"https://www.codemonkey.com/"}},{"title":"angular-profesional","progress":65,"completed":false,"tutor":{"name":"Codeacademy","link":"codecademy.com"}},{"title":"swift-introduccion","progress":21,"completed":false,"tutor":{"name":"Codemonkey ","link":"https://www.codemonkey.com/"}}]},
    {"_id":"1700","name":"Ver├│nica","courses":[{"title":"android-kotlin","progress":44,"completed":false,"tutor":{"name":"Code.org","link":"https://code.org/"}},{"title":"php-profesional","progress":27,"completed":false,"tutor":{"name":"C├│dgioFacilito","link":"https://codigofacilito.com/"}},{"title":"javascript-profesional","progress":32,"completed":false,"tutor":{"name":"Scratch","link":"https://scratch.mit.edu/"}},{"title":"angular-profesional","progress":16,"completed":false,"tutor":{"name":"Scratch","link":"https://scratch.mit.edu/"}},{"title":"ionic-v4","progress":37,"completed":false,"tutor":{"name":"Codeacademy","link":"codecademy.com"}}]},
    {"_id":"681","name":"Julia","courses":[{"title":"android-kotlin","progress":44,"completed":false,"tutor":{"name":"Scratch","link":"https://scratch.mit.edu/"}},{"title":"javascript-profesional","progress":75,"completed":false,"tutor":{"name":"C├│dgioFacilito","link":"https://codigofacilito.com/"}},{"title":"java-profesional","progress":71,"completed":false,"tutor":{"name":"Scratch","link":"https://scratch.mit.edu/"}},{"title":"git-profesional","progress":47,"completed":false,"tutor":{"name":"C├│dgioFacilito","link":"https://codigofacilito.com/"}},{"title":"flutter-sqlite","progress":29,"completed":false,"tutor":{"name":"C├│dgioFacilito","link":"https://codigofacilito.com/"}}]}
    ],
    "bookmark": "g1AAAAOVeJzNkDFOxDAQRUPYiKXJUiEkxA1IIhqEaJGgoOQAyPI48SROJtgTJM7FEbgY9nrTRNotaFgX9uj_r--nMUmSpDqFJHcsLHfq6x1IIvReP71_uAvWeraMF0_Clents9JpyGWMbFSYcjGAJYSiIzY4RHs9Wmqsck7cRuFcUj8axQogyWphnJp7JiYbq9MorQbRb5vP3qQVLPVO9uVdGK408-geq8pFu-yRSwVT1bZ7EC9b8Sl8GkcuPFitHNIgzBL19e-om6efb2iQnoVEg0wL5OsZWRJgQ_UuVfqf9lNfBOpDvC9HsNpNgwd3Wh3XTvPaTMzKFu7Dh9WS9uafaP35BQ92ADw"
}



// The $allMatch operator

{
    "_id": { "$gt": null },
    "genre": {
        "$allMatch": {
            "$eq": "Horror"
        }
    }
}

curl -X POST http://anna:secret@127.0.0.1:5984/pruebaproyecto/_find -H "Accept: application/json" -H "Content-Type: application/json" -d @consulta8.json

{
    "docs":[
    {
        "_id":"5358",
        "name":"Santiago",
        "courses":[
            {"title":"javascript-profesional","progress":0,"completed":false,"tutor":{"name":"Codeacademy","link":"codecademy.com"}}
        ]
    },
    {
        "_id":"5880",
        "name":"Mateo",
        "courses":[
            {"title":"javascript-profesional","progress":2,"completed":false,"tutor":{"name":"Codeacademy","link":"codecademy.com"}}
        ]
    },
    {
        "_id":"3965",
        "name":"Iv├ín",
        "courses":[
            {"title":"javascript-profesional","progress":4,"completed":false,"tutor":{"name":"Scratch","link":"https://scratch.mit.edu/"}},
            {"title":"javascript-profesional","progress":16,"completed":false,"tutor":{"name":"Codemonkey ","link":"https://www.codemonkey.com/"}}
        ]
    },
    {"_id":"9984","name":"Luc├¡a","courses":[{"title":"javascript-profesional","progress":6,"completed":false,"tutor":{"name":"C├│dgioFacilito","link":"https://codigofacilito.com/"}}]},
    {"_id":"6293","name":"Pablo","courses":[{"title":"javascript-profesional","progress":14,"completed":false,"tutor":{"name":"Code.org","link":"https://code.org/"}}]},
    {"_id":"1970","name":"Gabriel","courses":[{"title":"javascript-profesional","progress":16,"completed":false,"tutor":{"name":"Codemonkey ","link":"https://www.codemonkey.com/"}}]},
    {"_id":"3859","name":"Adri├ín","courses":[{"title":"javascript-profesional","progress":16,"completed":false,"tutor":{"name":"C├│dgioFacilito","link":"https://codigofacilito.com/"}}]},
    {"_id":"7588","name":"Julia","courses":[{"title":"javascript-profesional","progress":19,"completed":false,"tutor":{"name":"Codeacademy","link":"codecademy.com"}}]},
    {"_id":"957","name":"Camila","courses":[{"title":"javascript-profesional","progress":19,"completed":false,"tutor":{"name":"C├│dgioFacilito","link":"https://codigofacilito.com/"}}]},
    {"_id":"872","name":"Javier","courses":[{"title":"javascript-profesional","progress":21,"completed":false,"tutor":{"name":"Scratch","link":"https://scratch.mit.edu/"}}]},
    {"_id":"3010","name":"Valent├¡n","courses":[{"title":"javascript-profesional","progress":22,"completed":false,"tutor":{"name":"Codeacademy","link":"codecademy.com"}}]},
    {"_id":"3149","name":"Sergio","courses":[{"title":"javascript-profesional","progress":25,"completed":false,"tutor":{"name":"Codemonkey ","link":"https://www.codemonkey.com/"}}]},
    {"_id":"4615","name":"Jorge","courses":[{"title":"javascript-profesional","progress":27,"completed":false,"tutor":{"name":"Code.org","link":"https://code.org/"}}]},
    {"_id":"7766","name":"Elizabeth","courses":[{"title":"javascript-profesional","progress":27,"completed":false,"tutor":{"name":"Codeacademy","link":"codecademy.com"}}]},
    {"_id":"7644","name":"Mar├¡a","courses":[{"title":"javascript-profesional","progress":27,"completed":false,"tutor":{"name":"Codemonkey ","link":"https://www.codemonkey.com/"}}]},
    {"_id":"4289","name":"Renata","courses":[{"title":"javascript-profesional","progress":28,"completed":false,"tutor":{"name":"Codeacademy","link":"codecademy.com"}}]},
    {"_id":"200","name":"Javier","courses":[{"title":"javascript-profesional","progress":28,"completed":false,"tutor":{"name":"Scratch","link":"https://scratch.mit.edu/"}}]},
    {"_id":"3285","name":"Marcos","courses":[{"title":"javascript-profesional","progress":29,"completed":false,"tutor":{"name":"C├│dgioFacilito","link":"https://codigofacilito.com/"}}]},
    {"_id":"1032","name":"Lucy","courses":[{"title":"javascript-profesional","progress":32,"completed":false,"tutor":{"name":"Scratch","link":"https://scratch.mit.edu/"}}]},
    {"_id":"6373","name":"Javier","courses":[{"title":"javascript-profesional","progress":36,"completed":false,"tutor":{"name":"Scratch","link":"https://scratch.mit.edu/"}},{"title":"javascript-profesional","progress":66,"completed":false,"tutor":{"name":"C├│dgioFacilito","link":"https://codigofacilito.com/"}}]},
    {"_id":"3662","name":"David","courses":[{"title":"javascript-profesional","progress":40,"completed":false,"tutor":{"name":"Scratch","link":"https://scratch.mit.edu/"}}]},
    {"_id":"2552","name":"Adelaide","courses":[{"title":"javascript-profesional","progress":41,"completed":false,"tutor":{"name":"Code.org","link":"https://code.org/"}}]},
    {"_id":"3319","name":"Julia","courses":[{"title":"javascript-profesional","progress":44,"completed":false,"tutor":{"name":"C├│dgioFacilito","link":"https://codigofacilito.com/"}}]},
    {"_id":"2087","name":"Lucas","courses":[{"title":"javascript-profesional","progress":45,"completed":false,"tutor":{"name":"Code.org","link":"https://code.org/"}}]},
    {"_id":"5102","name":"Sof├¡a","courses":[{"title":"javascript-profesional","progress":48,"completed":false,"tutor":{"name":"Code.org","link":"https://code.org/"}}]}
    ],
    "bookmark": "g1AAAADgeJw1jcEOgjAQRGsDCV5MvPgXCpJ48eqHmKZdaGGhTXc18e-lFPawO3kz2UEhhLTSiBOxijzC7228dmZaePG4N23yqt3DhR7WZddTWJmCJTtGSOoyqK8iHV3ga4i-A3J-Vphj1UL6CESqyeCo_RQQGIwRZaeQYP_3YR9zhcyomNW0NlQvb-DmY79xdPOYxNkyB3rWtd78ekjzB334O9E"
}



// like -> expresión regular

{
    "selector": {
        "afieldname": {"$regex": "^A"}
    }
}



// Obtener todos los libros cuyo titulo comience con "Valen"
// WHERE title LIKE 'Valen%'

curl -X POST http://anna:secret@127.0.0.1:5984/pruebaproyecto/_find -H "Accept: application/json" -H "Content-Type: application/json" -d @consulta9.json

{
    "docs":[
    {"_id":"9999","name":"Valent├¡n","secondName":"Mart├¡n"},
    {"_id":"9917","name":"Valent├¡n","secondName":"Iv├ín"},
    {"_id":"9876","name":"Valent├¡n","secondName":"Diego"},
    {"_id":"9857","name":"Valent├¡n","secondName":"Nicol├ís"},
    {"_id":"9755","name":"Valent├¡n","secondName":"Dante"},
    {"_id":"9743","name":"Valent├¡n","secondName":"Erick"},
    {"_id":"9734","name":"Valent├¡n","secondName":"Jorge"},
    {"_id":"973","name":"Valent├¡n","secondName":"Mario"},
    {"_id":"9683","name":"Valent├¡n","secondName":"Valent├¡n"},
    {"_id":"9678","name":"Valent├¡n","secondName":"Santiago"},
    {"_id":"9524","name":"Valent├¡n","secondName":"Sim├│n"},
    {"_id":"9506","name":"Valent├¡n","secondName":"Iv├ín"},
    {"_id":"9363","name":"Valent├¡n","secondName":"Thiago"},
    {"_id":"9342","name":"Valent├¡n","secondName":"Valent├¡n"},
    {"_id":"9328","name":"Valent├¡n","secondName":"Juli├ín"},
    {"_id":"9253","name":"Valent├¡n","secondName":"Miguel"},
    {"_id":"9110","name":"Valent├¡n","secondName":"Miguel"},
    {"_id":"9097","name":"Valent├¡n","secondName":"Nicol├ís"},
    {"_id":"9081","name":"Valent├¡n","secondName":"Valent├¡n"},
    {"_id":"9067","name":"Valent├¡n","secondName":"Gabriel"},
    {"_id":"8965","name":"Valent├¡n","secondName":"Marcos"},
    {"_id":"8855","name":"Valent├¡n","secondName":"Mart├¡n"},
    {"_id":"8840","name":"Valent├¡n","secondName":"Benjam├¡n"},
    {"_id":"8781","name":"Valent├¡n","secondName":"David"},
    {"_id":"8769","name":"Valent├¡n","secondName":"Iv├ín"}
    ],
    "bookmark": "g1AAAABDeJzLYWBgYMpgSmHgKy5JLCrJTq2MT8lPzkzJBYqzWJibWYLkOGByOUBRRpAUZ1hiTmpeyeG1eVlZAE1TEr8"
}



// Obtener todos los libros cuyo titulo termine con "el"
// WHERE title LIKE '%el'

curl -X POST http://anna:secret@127.0.0.1:5984/pruebaproyecto/_find -H "Accept: application/json" -H "Content-Type: application/json" -d @consulta10.json

{   
    "docs":[
    {"_id":"1026","name":"├üngel","secondName":"Iv├ín"},
    {"_id":"1068","name":"├üngel","secondName":"Diego"},
    {"_id":"1137","name":"├üngel","secondName":"Javier"},
    {"_id":"1227","name":"├üngel","secondName":"Gabriel"},
    {"_id":"1328","name":"├üngel","secondName":"Lucas"},
    {"_id":"1411","name":"├üngel","secondName":"Benjam├¡n"},
    {"_id":"150","name":"├üngel","secondName":"Miguel"},
    {"_id":"1504","name":"├üngel","secondName":"Jorge"},
    {"_id":"1625","name":"├üngel","secondName":"Benjam├¡n"},
    {"_id":"169","name":"├üngel","secondName":"Sim├│n"},
    {"_id":"1777","name":"├üngel","secondName":"Miguel"},
    {"_id":"181","name":"├üngel","secondName":"Iv├ín"},
    {"_id":"1845","name":"├üngel","secondName":"Gabriel"},
    {"_id":"1902","name":"├üngel","secondName":"Lucas"},
    {"_id":"1951","name":"├üngel","secondName":"Dante"},
    {"_id":"2097","name":"├üngel","secondName":"Javier"},
    {"_id":"2250","name":"├üngel","secondName":"Mateo"},
    {"_id":"2262","name":"├üngel","secondName":"Lucas"},
    {"_id":"239","name":"├üngel","secondName":"Marcos"},
    {"_id":"24","name":"├üngel","secondName":"Thiago"},
    {"_id":"2411","name":"├üngel","secondName":"Thiago"},
    {"_id":"2445","name":"├üngel","secondName":"Mateo"},
    {"_id":"2669","name":"├üngel","secondName":"Carlos"},
    {"_id":"2746","name":"├üngel","secondName":"Benjam├¡n"},
    {"_id":"2970","name":"├üngel","secondName":"Santiago"}
    ],
    "bookmark": "g1AAAABAeJzLYWBgYMpgSmHgKy5JLCrJTq2MT8lPzkzJBYqzGFmaG4DkOGByOUBRRpAU2-HGvPTUnKwsABfZEVI"
}



// Obtener todos los libros cuyo titulo posea la palabra "an"
// WHERE title LIKE '%an%'

curl -X POST http://anna:secret@127.0.0.1:5984/pruebaproyecto/_find -H "Accept: application/json" -H "Content-Type: application/json" -d @consulta11.json

{
    "docs":[
    {"_id":"1152","name":"Daniel","secondName":"├ülvaro"},
    {"_id":"1357","name":"Daniel","secondName":"David"},
    {"_id":"1475","name":"Daniel","secondName":"Sim├│n"},
    {"_id":"159","name":"Daniel","secondName":"Mat├¡as"},
    {"_id":"1635","name":"Daniel","secondName":"Lucas"},
    {"_id":"1718","name":"Daniel","secondName":"Nicol├ís"},
    {"_id":"1831","name":"Daniel","secondName":"Iv├ín"},
    {"_id":"1850","name":"Daniel","secondName":"Benjam├¡n"},
    {"_id":"1950","name":"Daniel","secondName":"Santiago"},
    {"_id":"1955","name":"Daniel","secondName":"Manuel"},
    {"_id":"197","name":"Daniel","secondName":"├ülvaro"},
    {"_id":"1992","name":"Daniel","secondName":"Nicol├ís"},
    {"_id":"2060","name":"Daniel","secondName":"Carlos"},
    {"_id":"2113","name":"Daniel","secondName":"Sim├│n"},
    {"_id":"2184","name":"Daniel","secondName":"Mart├¡n"},
    {"_id":"2264","name":"Daniel","secondName":"Sim├│n"},
    {"_id":"228","name":"Daniel"},
    {"_id":"234","name":"Daniel","secondName":"Sim├│n"},
    {"_id":"2471","name":"Daniel","secondName":"Lucas"},
    {"_id":"2492","name":"Daniel","secondName":"Thiago"},
    {"_id":"2521","name":"Daniel","secondName":"Mart├¡n"},
    {"_id":"2526","name":"Daniel","secondName":"Valent├¡n"},
    {"_id":"2544","name":"Daniel","secondName":"Mario"},
    {"_id":"2567","name":"Daniel","secondName":"Sim├│n"},
    {"_id":"261","name":"Daniel","secondName":"Pablo"}
    ],
    "bookmark": "g1AAAAA_eJzLYWBgYMpgSmHgKy5JLCrJTq2MT8lPzkzJBYozG5kZgqQ4YFI5QEFGkAybS2JeZmpOVhYAA44Qew"
}




// Sintaxis de ordenamiento
// Indexamos por name y scores al tiempo

curl -X POST http://anna:secret@127.0.0.1:5984/pruebaproyecto/_index -H "Content-Type: application/json" -d @Index3.json

{
    "result":"created","id":"_design/name-scores","name":"name-scores"
}



[{"fieldName1": "desc"}, {"fieldName2": "desc" }]


curl -X POST http://anna:secret@127.0.0.1:5984/pruebaproyecto/_find -H "Accept: application/json" -H "Content-Type: application/json" -d @consulta12.json

{
    "docs":[
    {"_id":"5552","name":"Benjam├¡n","scores":[0,1,4,7,3,9,7,1,6,0]},
    {"_id":"7215","name":"Benjam├¡n","scores":[0,2,1,0]},
    {"_id":"7147","name":"Benjam├¡n","scores":[0,4,0,8]},
    {"_id":"7603","name":"Benjam├¡n","scores":[0,4,3,7]},
    {"_id":"3250","name":"Benjam├¡n","scores":[0,5,3,6,1,5,2,7,8]},
    {"_id":"3818","name":"Benjam├¡n","scores":[0,5,5,4,8,6,4,5,5,7]},
    {"_id":"977","name":"Benjam├¡n","scores":[0,8,9,5,3,1,8,0,1]},
    {"_id":"8563","name":"Benjam├¡n","scores":[0,9,3,3]},
    {"_id":"4309","name":"Benjam├¡n","scores":[0,9,9]},
    {"_id":"3109","name":"Benjam├¡n","scores":[1]},
    {"_id":"8032","name":"Benjam├¡n","scores":[1]},
    {"_id":"7173","name":"Benjam├¡n","scores":[1,0,8,7,9,7,3,9,6,6]},
    {"_id":"7850","name":"Benjam├¡n","scores":[1,1,0,8,9]},
    {"_id":"5776","name":"Benjam├¡n","scores":[1,3,4,1,3,1,0]},
    {"_id":"1781","name":"Benjam├¡n","scores":[1,4,6,4,4,4,5,1]},
    {"_id":"8093","name":"Benjam├¡n","scores":[1,4,7,8,8,9,9,2,4]},
    {"_id":"6826","name":"Benjam├¡n","scores":[1,6,6,3,9,1,3,7]},
    {"_id":"7304","name":"Benjam├¡n","scores":[1,6,8,9]},
    {"_id":"5486","name":"Benjam├¡n","scores":[1,7]},
    {"_id":"4565","name":"Benjam├¡n","scores":[1,7,4,0,3,3,8]},
    {"_id":"3446","name":"Benjam├¡n","scores":[1,7,4,8,3,8]},
    {"_id":"5181","name":"Benjam├¡n","scores":[1,8]},
    {"_id":"6936","name":"Benjam├¡n","scores":[1,8,4,5]},
    {"_id":"7217","name":"Benjam├¡n","scores":[1,8,9,0,6,9,3,4,2,2]},
    {"_id":"8705","name":"Benjam├¡n","scores":[1,9]}
    ],
    "bookmark": "g1AAAABIeJzLYWBgYMpgSmHgKy5JLCrJTq2MT8lPzkzJBYqzWJgbmILkOGByOSDVIClOp9S8rMTcw2vzshmYGDmzsgCm8BMQ"
}




// 1.3.7.1. Partial Indexes

{
  "index": {
    "partial_filter_selector": {
      "status": {
        "$ne": "archived"
      }
    },
    "fields": ["type"]
  },
  "ddoc" : "type-not-archived",
  "type" : "json"
}

curl -X POST http://anna:secret@127.0.0.1:5984/pruebaproyecto/_index -H "Content-Type: application/json" -d @Index4.json

{
    "result":"created",
    "id":"_design/sexM-age",
    "name":"sexM-age"
}

curl -X POST http://anna:secret@127.0.0.1:5984/pruebaproyecto/_find -H "Accept: application/json" -H "Content-Type: application/json" -d @consulta15.json

{
    "docs":[
    {"_id":"274","name":"Carlos","age":19,"sex":"M"},
    {"_id":"374","name":"Thiago","age":19,"sex":"M"},
    {"_id":"392","name":"Erick","age":19,"sex":"M"},
    {"_id":"526","name":"Marcos","age":19,"sex":"M"},
    {"_id":"610","name":"Javier","age":19,"sex":"M"},
    {"_id":"788","name":"Mario","age":19,"sex":"M"},
    {"_id":"835","name":"Lucas","age":19,"sex":"M"},
    {"_id":"121","name":"Jorge","age":20,"sex":"M"},
    {"_id":"160","name":"Sergio","age":20,"sex":"M"},
    {"_id":"24","name":"Adri├ín","age":20,"sex":"M"},
    {"_id":"43","name":"Marcos","age":20,"sex":"M"},
    {"_id":"690","name":"David","age":20,"sex":"M"},
    {"_id":"797","name":"Pablo","age":20,"sex":"M"},
    {"_id":"820","name":"Miguel","age":20,"sex":"M"},
    {"_id":"89","name":"David","age":20,"sex":"M"},
    {"_id":"937","name":"Thiago","age":20,"sex":"M"}
    ],
    "bookmark": "g2wAAAACaAJkAA5zdGFydGtleV9kb2NpZG0AAAADOTM3aAJkAAhzdGFydGtleWsAARRq"
}

curl -X POST http://anna:secret@127.0.0.1:5984/pruebaproyecto/_index -H "Content-Type: application/json" -d @Index5.json

{
    "result":"created",
    "id":"_design/courses.title:name-age",
    "name":"courses.title:name-age"
}

curl -X POST http://anna:secret@127.0.0.1:5984/pruebaproyecto/_find -H "Accept: application/json" -H "Content-Type: application/json" -d @consulta13.json

{
    "docs":[
    {
        "_id":"508","name":"Daniela","age":21,"sex":"F",
        "courses":[
            {"title":"swift-introduccion","progress":56,"completed":false,"tutor":{"name":"C├│dgioFacilito","link":"https://codigofacilito.com/"}},
            {"title":"flutter-sqlite","progress":53,"completed":false,"tutor":{"name":"Codeacademy","link":"codecademy.com"}},
            {"title":"javascript-profesional","progress":52,"completed":false,"tutor":{"name":"C├│dgioFacilito","link":"https://codigofacilito.com/"}},
            {"title":"android-kotlin","progress":77,"completed":false,"tutor":{"name":"C├│dgioFacilito","link":"https://codigofacilito.com/"}},
            {"title":"flutter-sqlite","progress":93,"completed":false,"tutor":{"name":"Code.org","link":"https://code.org/"}}
        ]
    },
    {
        "_id":"918","name":"Julia","age":22,"sex":"F",
        "courses":[
            {"title":"java-profesional","progress":89,"completed":false,"tutor":{"name":"Scratch","link":"https://scratch.mit.edu/"}},
            {"title":"ionic-v5","progress":94,"completed":false,"tutor":{"name":"Scratch","link":"https://scratch.mit.edu/"}},
            {"title":"nosql-moongodb","progress":49,"completed":false,"tutor":{"name":"Codemonkey ","link":"https://www.codemonkey.com/"}},
            {"title":"javascript-profesional","progress":72,"completed":false,"tutor":{"name":"Codemonkey ","link":"https://www.codemonkey.com/"}}
        ]
    },
    {
        "_id":"183","name":"Renata","age":25,"sex":"F",
        "courses":[
            {"title":"frontend-profesional","progress":4,"completed":false,"tutor":{"name":"C├│dgioFacilito","link":"https://codigofacilito.com/"}},
            {"title":"javascript-profesional","progress":51,"completed":false,"tutor":{"name":"Codemonkey ","link":"https://www.codemonkey.com/"}},
            {"title":"android-profesional","progress":57,"completed":false,"tutor":{"name":"Codemonkey ","link":"https://www.codemonkey.com/"}},
            {"title":"frontend-profesional","progress":24,"completed":false,"tutor":{"name":"Codemonkey ","link":"https://www.codemonkey.com/"}}
        ]
    }
    ],
    "bookmark": "g1AAAABBeJzLYWBgYMpgSmHgKy5JLCrJTq2MT8lPzkzJBYozG1oYg6Q4YFI5IMUgGbag1LzEksREyawsACW8EQc",
    "warning": "The number of documents examined is high in proportion to the number of results returned. Consider adding a more specific index to improve this."
}

curl -X POST http://anna:secret@127.0.0.1:5984/pruebaproyecto/_index -H "Content-Type: application/json" -d @Index6.json

{
    "result":"created",
    "id":"_design/courses.completed:true",
    "name":"courses.completed:true"
}

curl -X POST http://anna:secret@127.0.0.1:5984/pruebaproyecto/_find -H "Accept: application/json" -H "Content-Type: application/json" -d @consulta14.json

{
    "docs":[
        {
            "_id":"375","name":"Eleanor","age":22,
            "courses":[
                {"title":"php-profesional","progress":100,"completed":true,"tutor":{"name":"C├│dgioFacilito","link":"https://codigofacilito.com/"}}
            ]
        }
    ],
    "bookmark": "g1AAAADoeJw1jcENwjAMRUMoUrnAAMwAPSCExBWJNVAUp40hraPEPTAXI7AYSdP6YH-9__XthBDSShC7yCrw23yeQBqhT3x9vl6yVS-WS3A1LTudysqc2zCyM1ntvfVHH6g1EWlQrvh1Il0wMSooYKup986wARAVh9EsPSNTKNWyoGpQfWm-_77QIT2URodMs-1weGdxsMw-3ppGE2BH7Zw6pUfNK88fZg9AXA",
    "execution_stats": {"total_keys_examined":0,"total_docs_examined":831,"total_quorum_docs_examined":0,"results_returned":1,"execution_time_ms":1787.0},
    "warning": "The number of documents examined is high in proportion to the number of results returned. Consider adding a more specific index to improve this."
}




// POST /{db}/_explain

POST /movies/_explain HTTP/1.1
Accept: application/json
Content-Type: application/json
Content-Length: 168
Host: localhost:5984
{
    "selector": {
        "year": {"$gt": 2010}
    },
    "fields": ["_id", "_rev", "year", "title"],
    "sort": [{"year": "asc"}],
    "limit": 2,
    "skip": 0
}

curl -X POST http://anna:secret@127.0.0.1:5984/pruebaproyecto/_explain -H "Accept: application/json" -H "Content-Type: application/json" -d @consulta14.json

{
    "dbname":"pruebaproyecto",
    "index":{
        "ddoc":"_design/courses.completed:true",
        "name":"courses.completed:true",
        "type":"json",
        "partitioned":false,
        "def":{
            "fields":[],
            "partial_filter_selector":{
                "courses":{"$elemMatch":{"completed":{"$eq":true}}
                }
            }
        }
    },
    "partitioned":false,
    "selector":{
        "courses":{"$allMatch":{"completed":{"$eq":true}}}
    },
    "opts":{
        "use_index":["courses.completed:true"],
        "bookmark":"nil",
        "limit":25,
        "skip":0,
        "sort":{},
        "fields":["_id","name","age","courses"],
        "partition":"",
        "r":[49],
        "conflicts":false,
        "stale":false,
        "update":true,
        "stable":false,
        "execution_stats":true
    },
    "limit":25,
    "skip":0,
    "fields":["_id","name","age","courses"],
    "mrargs":{
        "include_docs":true,
        "view_type":"map",
        "reduce":false,
        "partition":null,
        "start_key":[],
        "end_key":["<MAX>"],
        "direction":"fwd",
        "stable":false,
        "update":true,
        "conflicts":"undefined"
    }
}

curl -X POST http://anna:secret@127.0.0.1:5984/pruebaproyecto/_explain -H "Accept: application/json" -H "Content-Type: application/json" -d @consulta13.json

{
    "dbname":"pruebaproyecto",
    "index":{
        "ddoc":"_design/courses.title:name-age",
        "name":"courses.title:name-age",
        "type":"json",
        "partitioned":false,
        "def":{
            "fields":[{"name":"asc"},{"age":"asc"}],
            "partial_filter_selector":{
                "courses":{"$elemMatch":{"title":{"$in":["javascript-profesional","php-profesional","mongoose","docker-swarm","ionic-v4"]}}}
            }
        }
    },
    "partitioned":false,
    "selector":{
        "$and":[{"courses":{"$elemMatch":{"$and":[{"title":{"$eq":"javascript-profesional"}},{"progress":{"$gte":50}}]}}},{"age":{"$lte":25}}]
    },
    "opts":{
        "use_index":["courses.title:name-age"],
        "bookmark":"nil",
        "limit":25,
        "skip":0,
        "sort":{"name":"asc","age":"asc"},
        "fields":["_id","name","age","sex","courses"],
        "partition":"",
        "r":[49],
        "conflicts":false,
        "stale":false,
        "update":true,
        "stable":false,
        "execution_stats":true
    },
    "limit":25,
    "skip":0,
    "fields":["_id","name","age","sex","courses"],
    "mrargs":{
        "include_docs":true,
        "view_type":"map",
        "reduce":false,
        "partition":null,
        "start_key":[],
        "end_key":["<MAX>"],
        "direction":"fwd",
        "stable":false,
        "update":true,
        "conflicts":"undefined"
    }
}






// PROJECT:


// 5. ¿Cuáles personas tienen un texto específico y que tengan entre 5 y 10 calificaciones?

curl -X POST http://anna:secret@127.0.0.1:5984/pruebaproyecto/_find -H "Accept: application/json" -H "Content-Type: application/json" -d @C:\Users\hamil\OneDrive\Documents\GitHub\hamiltonsalazar.github.com\CouchDB\consulta16.json



// 12. Mostrar la información de la última compra del producto XYZ de un cliente XYZ.

curl "http://anna:secret@localhost:5984/pruebaproyecto/_design/viewsales/_view/sales_products_name:date?startkey=\[1,\]&endkey=\[1,{}\]"

