import js.Promise;

@:jsRequire("./agentscreen", "AgentScreen")
extern class AgentScreen {
    function new(loginUrl:String);
    
    public function run(?delay:Int):Void;
    public function screenshot():Promise<String>;
    public function close():Void;
}
