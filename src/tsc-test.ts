Macro.add("TSC-Test",{
    skipArgs: true,
    handler: function(){
        const message:string = "<b>TypeScript ist aktiviert.</b>"; //Note the TS-specific type-annotation

        new Wikifier(this.output, message);
    }
})