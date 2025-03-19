window.SpielCharacter = class SpielCharacter {

    name = "Nobody";
    _geburtsdatum = new Date(1980,0,1);

    get geburtsdatum(){
        return this._geburtsdatum;
    }
    set geburtsdatum(v){
        if (typeof v == "string") {
            const datumTeile = v.split(".");
            const tag = datumTeile[0];
            const monat = datumTeile[1] - 1; //Januar ist Monat 0
            const jahr = datumTeile[2];
            this._geburtsdatum = new Date(jahr, monat, tag);
        }
        else
            this._geburtsdatum = v;
        console.log("setze",this._geburtsdatum);
    }

    constructor(...config){

        console.warn(config);

        if(config.length == 1 && typeof config[0] == "object")
            this.constructorMitConfigObject(config[0]);
        else{
            this.name = config[0];
            this.geburtsdatum = config[1];
        }
    }

    constructorMitConfigObject(config){
        if (config.name)
            this.name = config.name;

        if (config._geburtsdatum)
            this._geburtsdatum = config._geburtsdatum;
    }

    get alterInJahren(){
        const jetzt = new Date();
        if (jetzt.getMonth() > this.geburtsdatum.getMonth())
            return jetzt.getFullYear() - this.geburtsdatum.getFullYear();
        if (jetzt.getMonth() < this.geburtsdatum.getMonth())
            return jetzt.getFullYear() - this.geburtsdatum.getFullYear() - 1;
        if (jetzt.getDate() >= this.geburtsdatum.getDate())
            return jetzt.getFullYear() - this.geburtsdatum.getFullYear();
        return jetzt.getFullYear() - this.geburtsdatum.getFullYear() - 1;
    }

    get alterInTagen(){
        const jetzt = new Date();
        return Math.floor((jetzt.getTime() - this.geburtsdatum.getTime())/(24 * 60 * 60 * 1000));
    }

    //#region Serialization
    clone(){
        return new this.constructor(this);
    }

    toJSON() {
        var ownData = {};
        Object.keys(this).forEach(function (prop) {
            ownData[prop] = clone(this[prop]);
        }, this);
        console.warn("owndata",ownData,this);
        return Serial.createReviver(`new ${this.constructor.name}($ReviveData$)`, ownData);
    }
    //#endregion

}
