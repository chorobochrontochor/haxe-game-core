/*
 *	Copyright 11/25/2017 Michal Deak. All rights reserved.
 */
package core.command;

import com.genome2d.context.GContextConfig;
import com.genome2d.Genome2D;
import core.command.base.Command;

class InitializeGenomeCommand extends Command {

    public function new() {
        super();
    }

    override public function execute():Void {
        var genome:Genome2D = Genome2D.getInstance();
        var config:GContextConfig = new GContextConfig();

        genome.onInitialized.add(onGenomeSucceed);
        genome.onFailed.add(onGenomeFailed);
        genome.init(config);
    }

    private function onGenomeSucceed():Void {
        onCommandSucceed();
    }

    private function onGenomeFailed(msg:String):Void {
        onCommandFailed();
    }
}
