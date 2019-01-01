import js.node.http.IncomingMessage;
import AgentScreen;
import js.node.Http;
import js.Node.console;

class Server
{
    var action:String;
    var agentScreen:AgentScreen;

    var param:haxe.ds.Map<String,Dynamic>;

    public function new()
    {
        Http.createServer(function(req:js.node.http.IncomingMessage, res:js.node.http.ServerResponse)
        {
            //console.log(req.url);
            var q:Array<String> = req.url.split('/');
            q.shift();
            //trace(q);
            action = q.shift();
            trace('action:$action');
            switch (action)
            {
                case 'start':
                    param = [
                        while (q.length>0) q.shift()=>q.shift()
                    ];
                    //console.log(param);
                    agentScreen = new AgentScreen(
    'https://xpress.mein-dialer.com/agc/vicidial.fly-xpress.php?relogin=YES&VD_login=${param["VD_login"]}&VD_campaign=${param["VD_campaign"]}&phone_login=${param["phone_login"]}&phone_pass=${param["phone_pass"]}&VD_pass=${param["VD_pass"]}');
                    agentScreen.run();
                    res.writeHead(200, {'Content-Type':'text/plain'});
                    res.end('Hello World\n');
                case 'screenshot':
                    res.writeHead(200, {'Content-Type':'image/jpeg'});
                    agentScreen.screenshot().then(function (shot:String)res.end(shot));
                    //agentScreen.screenshot().then(function (shot:String)trace(shot));
                    //res.end(agentScreen.screenshot().then(function (shot:String)return shot));
                    //res.end('agentScreen.screenshot()');
                //case 'logout':
                case 'logout':
                    agentScreen.close();
                    res.writeHead(200, {'Content-Type':'text/plain'});
                    res.end('Goodbye\n');
            }           
        }).listen(process.env.PORT, '127.0.0.1');
        console.log('Server running at 1337');
    }
}
/* var ag:AgentScreen = new AgentScreen();
        ag.run();
https://xpress.mein-dialer.com/agc/vicidial.fly-xpress.php?relogin=YES&VD_login=6666&VD_campaign=QCKINDER&phone_login=666&phone_pass=666ohne&VD_pass=dial4NICHTS        
        */