package com.example.BlockPuzzle{

import avmplus.typeXml;

import data.CirlcleData;
import data.NumberBaseData;

import flash.display.Loader;
import flash.display.Screen;
import flash.display.Shader;
import flash.display.Shape;
import flash.display.Sprite;
import flash.events.Event;
import flash.events;
import flash.events.GameInputEvent;
import flash.geom.ColorTransform;
import flash.net.registerClassAlias;
import flash.text.TextField;
import flash.events.MouseEvent;
import flash.text.TextFormat;
import flash.text.engine.TextElement;
import flash.ui.Mouse;
import flash.geom.Point;
public class Main extends Sprite {

    var listSprite:Array = [];
    var sprite:Sprite = new Sprite();
    var sprite1:Sprite = new Sprite();
    var loader:Loader = new Loader();
    var n:int = 0;
    var nextNumber:int = 2;
    var txtNextNumber:TextField = new TextField();
    var listIntBase:Array = [];
    var numberNextBase:NumberBaseData = new NumberBaseData();
    var switchCheck:Boolean = true;
    var isPlusType:Boolean = true;
    var x1:int;
    var y1:int;

    public function Main() {
        loadGame();
    }
    private  function loadGame():void{
        loadBoard();
        loadNextNumber();
        loadBase();
    }

    private function loadNextNumber():void {
        var sprite:Sprite = new Sprite();
        sprite.graphics.clear();
        sprite.graphics.beginFill(0xFF4600, 0);
        sprite.graphics.drawEllipse(0, 0, 40, 40);
        sprite.graphics.endFill();
        sprite.x = width / 2 - 20-75;
        sprite.y = -50+5;
        drawHex( width / 2 - 20-75+20,-50+20).transform.colorTransform=new ColorTransform(0xF0FF00);

        var sprite1:Sprite = new Sprite();
        sprite1.graphics.clear();
        sprite1.graphics.beginFill(0xFF8E63, 1);
        sprite1.graphics.drawEllipse(0, 0, 30, 30);
        sprite1.x =width / 2 - 20 - 40-75;
        sprite1.y = -50 + 10;
        sprite1.graphics.endFill();
        sprite1.transform.colorTransform=new ColorTransform(0xF0FF00);
        var sprite2:Sprite = new Sprite();
        sprite2.graphics.clear();
        sprite2.graphics.beginFill(0xFF8E63, 1);
        sprite2.graphics.drawEllipse(0, 0, 30, 30);
        sprite2.x = width / 2 - 20 + 40 + 10-75;
        sprite2.y = -50 + 10;
        sprite2.graphics.endFill();
        sprite2.transform.colorTransform=new ColorTransform(0xF0FF00);
        addChild(sprite);
        addChild(sprite1);
        addChild(sprite2);
        txtNextNumber.text = nextNumber.toString();
        txtNextNumber.x = sprite.x;
        txtNextNumber.y = sprite.y ;
        txtNextNumber.width=40;
        txtNextNumber.height=40;
        var tf:TextFormat=new TextFormat();
        tf.bold=true;
        tf.size=22;
        tf.font="Arial";
        tf.align="center";
        var txtPlus:TextField = new TextField();
        txtPlus.x = sprite2.x + 10;
        txtPlus.y = sprite2.y + 6;
        txtPlus.text = "+";
        txtPlus.width=30;
        txtPlus.height=30;
        txtPlus.mouseEnabled = false;
        txtPlus.defaultTextFormat=tf;
        var txtSub:TextField = new TextField();
        txtSub.x = sprite1.x + 10;
        txtSub.y = sprite1.y + 6;
        txtSub.text = "-";
        txtSub.mouseEnabled = false;
        txtSub.defaultTextFormat=tf;
        txtNextNumber.mouseEnabled = false;

        txtNextNumber.defaultTextFormat=tf;


        addChild(txtNextNumber);
        addChild(txtPlus);
        addChild(txtSub);
        sprite1.addEventListener(MouseEvent.MOUSE_DOWN, onClickSub);
        sprite2.addEventListener(MouseEvent.MOUSE_DOWN, onClickPlus);
    }

    private function onClickPlus(event:MouseEvent):void {
        trace("plus");
        var tempPlus = nextNumber;
        while (true) {
            tempPlus++;
            if (tempPlus == 37 || checkBoard(tempPlus) == false) break;
        }
        if(tempPlus<37){
            nextNumber = tempPlus;
            txtNextNumber.text = nextNumber.toString();
            isPlusType = true;
        }
    }

    private function onClickSub(event:MouseEvent):void {
        trace("sub");
        var temp:int = nextNumber;
        while (true) {
            temp--;
            if (temp == 0 || checkBoard(temp) == false) break;
        }
        if (temp != 0) {
            nextNumber = temp;
            txtNextNumber.text = nextNumber.toString();
            isPlusType = false;
        }
    }

    private function setPosition(sprite:Sprite, x:Number, y:Number) {
        sprite.x = x;
        sprite.y = y;
    }

    private function loadBoard():void {
        var BG:Sprite = new Sprite();
        BG.graphics.clear();
        BG.graphics.beginFill(0x00FF83, 1);
        BG.graphics.drawRect(0,-100,640,920);
        BG.graphics.endFill();
        addChild(BG);
        for (var i:int = 0; i < 7; i++) {
            var arr:Array = [];
            if (i <= 3) {
                for (var j:int = 0; j < 4 + i; j++) {
                    var circle:CirlcleData = new CirlcleData();
                    circle.shape=drawHex(80 - 20 * i + 100 + 44 * j - 2*i,39 * i+20);
                    var sprite:Sprite = new Sprite();
                    sprite.graphics.clear();
                    sprite.graphics.beginFill(0xBAF6F7, 1);
                    sprite.graphics.drawEllipse(0, 0, 40, 40);
                    sprite.x = 60 - 20 * i + 100 + 44 * j- 2*i;
                    sprite.y = 39 * i;
                    sprite.alpha=0;
                    sprite.graphics.endFill();
                    sprite.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDownCircle);
                    sprite.addEventListener(MouseEvent.MOUSE_OVER, onMouseMoveCircle);
                    sprite.addEventListener(MouseEvent.MOUSE_OUT, onMouseOutCircle);
                    addChild(sprite);
                    circle.sprite = sprite;
                    var textfield:TextField = new TextField();
                    textfield.textColor = 0x000000;
                    textfield.x = sprite.x;
                    textfield.y = sprite.y+5;
                    textfield.mouseEnabled = false;
                    textfield.width=40;
                    textfield.height=40;
                    var tf:TextFormat=new TextFormat();
                    tf.bold=true;
                    tf.font="Arial";
                    tf.size=18;
                    tf.align="center";
                    textfield.defaultTextFormat=tf;
                    addChild(textfield);
                    circle.txtCurrentNumber = textfield;
                    var corTran:ColorTransform = new ColorTransform();
                    corTran.color = 0xFF4803;
                    circle.colorBase = corTran;
                    arr[j] = circle;

                }
            } else {
                for (var j:int = 0; j < 10 - i; j++) {
                    var circle:CirlcleData = new CirlcleData();
                    circle.shape=drawHex(20 * (i - 3) + 100 + 44 * j+20-3,39 * i+20);
                    var sprite:Sprite = new Sprite();
                    sprite.graphics.clear();
                    sprite.graphics.beginFill(0xBAF6F7, 1);
                    sprite.graphics.drawEllipse(0, 0, 40, 40);
                    sprite.x = 20 * (i - 3) + 100 + 44 * j-3;
                    sprite.y = 39 * i;
                    sprite.alpha=0;
                    sprite.graphics.endFill();
                    sprite.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDownCircle);
                    sprite.addEventListener(MouseEvent.MOUSE_OVER, onMouseMoveCircle);
                    sprite.addEventListener(MouseEvent.MOUSE_OUT, onMouseOutCircle);
                    addChild(sprite);
                    circle.sprite = sprite;
                    var textfield:TextField = new TextField();
                    textfield.textColor = 0x000000;
                    textfield.x = sprite.x ;
                    textfield.y = sprite.y+5 ;
                    textfield.mouseEnabled = false;
                    textfield.width=40;
                    textfield.height=40;
                    var tf:TextFormat=new TextFormat();
                    tf.bold=true;
                    tf.size=18;
                    tf.font="Arial";
                    tf.align="center";
                    textfield.defaultTextFormat=tf;
                    addChild(textfield);
                    circle.txtCurrentNumber = textfield;
                    var corTran:ColorTransform = new ColorTransform();
                    corTran.color = 0xFF4803;
                    circle.colorBase = corTran;
                    arr[j] = circle;
                }
            }
            listSprite[i] = arr;

        }
        listSprite[3][3].setTextString("");
        var corTran:ColorTransform = new ColorTransform();
        corTran.color = 0x46FF00;
        listSprite[3][3].shape.transform.colorTransform = corTran;
        (listSprite[3][3].sprite as Sprite).removeEventListener(MouseEvent.MOUSE_OUT, onMouseOutCircle);
        listSprite[3][3] = null;
    }

    private function onMouseOutCircle(event:MouseEvent):void {
        var corTran:ColorTransform = new ColorTransform();
        corTran.color = 0xBAF6F7;
     //   (event.currentTarget as Sprite).transform.colorTransform = corTran;

        for (var i:int = 0; i < 7; i++) {
            for (var j:int = 0; j < 7; j++) {
                if (listSprite[i][j] != null && listSprite[i][j].sprite == event.currentTarget) {
                    var corTran:ColorTransform = new ColorTransform();
                    corTran.color = 0xBAF6F7;
                    listSprite[i][j].shape.transform.colorTransform= corTran;
                }
            }
        }
    }

    private function onMouseMoveCircle(event:MouseEvent):void {
        for (var i:int = 0; i < 7; i++) {
            for (var j:int = 0; j < 7; j++) {
                if (listSprite[i][j] != null && listSprite[i][j].sprite == event.currentTarget) {
                  // (event.currentTarget as Sprite).transform.colorTransform = listSprite[i][j].colorBase;
                    listSprite[i][j].shape.transform.colorTransform= listSprite[i][j].colorBase;
                }
            }
        }
    }

    private function onMouseDownCircle(event:MouseEvent):void {
        for (var i:int = 0; i < 7; i++) {
            for (var j:int = 0; j < 7; j++) {
                if (listSprite[i][j] != null && listSprite[i][j].sprite == event.currentTarget) {

                    if (listSprite[i][j].isNumberSuggest) {

                        onIsNumberSuggest(listSprite[i][j]);
                    } else {
                        if (listSprite[i][j].isFillNumber) {
                            onIsFill(listSprite[i][j]);
                        } else {
                            onNotFill(listSprite[i][j]);
                        }
                    }

                }
            }
        }
    }

    private function onIsNumberSuggest(cir:CirlcleData):void {
        trace("Sugget");


        if (switchCheck) {
            var temp:int = cir.id;
            while (true) {
                temp--;
                if (temp == 0 || checkBoard(temp) == false) break;
            }
            if (temp != 0) {
                nextNumber = temp;
                txtNextNumber.text = nextNumber.toString();
                isPlusType = false;
                switchCheck = !switchCheck;
            }else {
                var tempPlus = cir.id;
                while (true) {
                    tempPlus++;
                    if (tempPlus == 37 || checkBoard(tempPlus) == false) break;
                }
                if(tempPlus)
                nextNumber = tempPlus;
                txtNextNumber.text = nextNumber.toString();
                isPlusType = true;
                switchCheck = !switchCheck;
            }

        } else {
            var tempPlus = cir.id;
            while (true) {
                tempPlus++;
                if (tempPlus == 37 || checkBoard(tempPlus) == false) break;
            }
            if(tempPlus<37){
                nextNumber = tempPlus;
                txtNextNumber.text = nextNumber.toString();
                isPlusType = true;
                switchCheck = !switchCheck;
            }
        }
    }

    private function checkBoard(a:int):Boolean {
        for (var i:int = 0; i < 7; i++) {
            for (var j:int = 0; j < 7; j++) {
                if (listSprite[i][j] != null) {
                    if (a == listSprite[i][j].id) {
                        return true;
                    }
                }
            }
        }
        return false;
    }

    private function onNotFill(cir:CirlcleData):void {
        cir.isFillNumber = true;
        cir.getText().text = txtNextNumber.text;
        cir.id = nextNumber;
        var key:int=0;
        if (isPlusType) {
            var tempPlus = cir.id;
            while (true) {
                tempPlus++;
                key=tempPlus == 37?37:0;
                if (tempPlus == 37 || checkBoard(tempPlus) == false){
                    break;
                }
            }
            if(tempPlus<37){
                nextNumber = tempPlus;
                txtNextNumber.text = nextNumber.toString();
            }else{
                var temp:int = cir.id;
                while (true) {
                    temp--;
                    if (temp == 0 || checkBoard(temp) == false) break;
                }
                nextNumber = temp;
                txtNextNumber.text = nextNumber.toString();
                if (temp == 0) {
                    var tempPlus = cir.id;
                    while (true) {
                        tempPlus++;
                        key=tempPlus == 37?37:0;
                        if (tempPlus == 37 || checkBoard(tempPlus) == false){
                            break;
                        }
                    }
                    nextNumber = tempPlus;
                    txtNextNumber.text = nextNumber.toString();
                    isPlusType = true;
                }
            }
        } else {
            var temp:int = cir.id;
            while (true) {
                temp--;
                if (temp == 0 || checkBoard(temp) == false) break;
            }
            nextNumber = temp;
            txtNextNumber.text = nextNumber.toString();
            if (temp == 0) {
                var tempPlus = cir.id;
                while (true) {
                    tempPlus++;
                    key=tempPlus == 37?37:0;
                    if (tempPlus == 37 || checkBoard(tempPlus) == false){
                        break;
                    }
                }
                nextNumber = tempPlus;
                txtNextNumber.text = nextNumber.toString();
                isPlusType = true;
            }
        }
        if(startCheck()){
            if(checkWin(x1,y1,listSprite[x1][y1])){
                popupWin("You Won!");
            }else {
                popupWin("You Lose!");
            }
        }
    }

    private function popupWin( mess:String ):void {
        var popupWin:Sprite=new Sprite();
        popupWin.graphics.clear();
        popupWin.graphics.beginFill(0xFFFFFF,0.9);
        popupWin.graphics.drawRoundRect(width / 2-75-200,-70,400,550,20,20);
        popupWin.graphics.endFill();
        addChild(popupWin);
        var tf:TextFormat = new TextFormat();
        tf.size = 30;
        tf.bold = true;
        tf.font = "Arial"
        tf.color = 0x000000;
        tf.align="center";
        var capt:TextField = new TextField();
        capt.defaultTextFormat = tf;
        capt.width = 200;
        capt.height = 40;
        capt.text = mess;
        capt.y = 0;
        capt.x = width/2-75-100;
        capt.border = false;
        capt.selectable = false;
        var txtRestart:TextField = new TextField();
        tf.color=0x00FF8F;
        txtRestart.defaultTextFormat = tf;
        txtRestart.width = 200;
        txtRestart.height = 40;
        txtRestart.text = "Restart!";
        txtRestart.y = 200;
        txtRestart.x = width/2-75-100;
        addChild(capt);
        addChild(txtRestart);
        txtRestart.addEventListener(MouseEvent.CLICK, resetGame);
    }
    private function resetGame(event:MouseEvent):void {
        loadGame();
    }
    
    private function startCheck():Boolean {
        for (var i:int = 0; i < 7; i++) {
            for (var j:int = 0; j < 7; j++) {
                if (listSprite[i][j] != null) {
                    if(listSprite[i][j].isFillNumber==false){
                        return  false;
                    }
                }
            }
        }
        return true;
    }

    private function checkWin(i:int,j:int,cir:CirlcleData):Boolean {
        if(cir.id==36){
            return true;
        }
        var templist:Array = new Array();
        if (listSprite[i][j - 1] != null ) {
            listSprite[i][j - 1].x = i;
            listSprite[i][j - 1].y = j - 1;
            templist.push(listSprite[i][j - 1]);
        }
        if (listSprite[i][j + 1] != null ) {
            listSprite[i][j + 1].x = i;
            listSprite[i][j + 1].y = j + 1;
            templist.push(listSprite[i][j + 1]);
        }
        if (i < 3) {

            if (i - 1 >= 0 && i - 1 < 7 && j - 1 >= 0 && j - 1 < 7 && listSprite[i - 1][j - 1] != null) {
                    listSprite[i - 1][j - 1].x = i - 1;
                    listSprite[i - 1][j - 1].y = j - 1;
                    templist.push(listSprite[i - 1][j - 1]);
            }
            if (i - 1 >= 0 && i - 1 < 7 && j >= 0 && j < 7 && listSprite[i - 1][j] != null ) {
                listSprite[i - 1][j].x = i - 1;
                listSprite[i - 1][j].y = j;
                templist.push(listSprite[i - 1][j]);
            }
            if (i + 1 >= 0 && i + 1 < 7 && j >= 0 && j < 7 && listSprite[i + 1][j] != null ) {
                listSprite[i + 1][j].x = i + 1;
                listSprite[i + 1][j].y = j;
                templist.push(listSprite[i + 1][j]);
            }
            if (i + 1 >= 0 && i + 1 < 7 && j + 1 >= 0 && j + 1 < 7 && listSprite[i + 1][j + 1] != null ) {
                listSprite[i + 1][j + 1].x = i + 1;
                listSprite[i + 1][j + 1].y = j + 1;
                templist.push(listSprite[i + 1][j + 1]);
            }
        } else {
            if (i == 3) {
                if (listSprite[i - 1][j - 1] != null ) {
                    listSprite[i - 1][j - 1].x = i - 1;
                    listSprite[i - 1][j - 1].y = j - 1;
                    templist.push(listSprite[i - 1][j - 1]);
                }
                if (listSprite[i + 1][j] != null ) {
                    listSprite[i + 1][j].x = i + 1;
                    listSprite[i + 1][j].y = j;
                    templist.push(listSprite[i + 1][j]);
                }
                if (listSprite[i + 1][j - 1] != null ) {
                    listSprite[i + 1][j - 1].x = i + 1;
                    listSprite[i + 1][j - 1].y = j - 1;
                    templist.push(listSprite[i + 1][j - 1]);
                }
                if (listSprite[i - 1][j] != null ) {
                    listSprite[i - 1][j].x = i -1;
                    listSprite[i - 1][j].y = j;
                    templist.push(listSprite[i - 1][j]);
                }
            } else {
                if (i + 1 >= 0 && i + 1 < 7 && j >= 0 && j < 7 && listSprite[i + 1][j] != null ) {
                    listSprite[i + 1][j].x = i + 1;
                    listSprite[i + 1][j].y = j;
                    templist.push(listSprite[i + 1][j]);
                }
                if (i - 1 >= 0 && i - 1 < 7 && j + 1 >= 0 && j + 1 < 7 && listSprite[i - 1][j + 1] != null ) {
                    listSprite[i - 1][j + 1].x = i - 1;
                    listSprite[i - 1][j + 1].y = j + 1;
                    templist.push(listSprite[i - 1][j + 1]);
                }
                if (i + 1 >= 0 && i + 1 < 7 && j - 1 >= 0 && j - 1 < 7 && listSprite[i + 1][j - 1] != null ) {
                    listSprite[i + 1][j - 1].x = i + 1;
                    listSprite[i + 1][j - 1].y = j - 1;
                    templist.push(listSprite[i + 1][j - 1]);
                }
                if (i - 1 >= 0 && i - 1 < 7 && j >= 0 && j < 7 && listSprite[i - 1][j] != null ) {
                    listSprite[i - 1][j].x = i - 1;
                    listSprite[i- 1][j].y = j;
                    templist.push(listSprite[i - 1][j]);
                }
            }
        }


        for(var i:int=0;i<templist.length;i++){
            if(templist[i].id==cir.id+1){
                return true&&checkWin(templist[i].x,templist[i].y,templist[i]);
            }
        }
        var tempB:Boolean=false;
        for(var i:int=0;i<templist.length;i++){
            if(templist[i].id==cir.id+1){
                tempB=true;
            }
        }
        trace("end");
        trace(cir.id);
        return tempB;
    }

    private function onIsFill(cir:CirlcleData):void {
        cir.isFillNumber = false;
        nextNumber = cir.id;
        cir.id=0;
        txtNextNumber.text = nextNumber.toString();
        cir.getText().text = "";

    }


    private function loadBase():void {
        while (true) {
//            var x:int=Math.random()*7;
//            var n:int=0;
//            trace(x);
            //    var nestBase:int=0;
            // nestBase = 0;
            for (var i:int = 0; i < 7; i++) {
                for (var j:int = 0; j < 7; j++) {
                    if (listSprite[i][j] != null) {
                        listSprite[i][j].isSetIntRandom = false;
                    }
                }
            }

            numberNextBase.nextBase = 0;
            while (true) {
                x1 = Math.random() * 7;
                y1 = Math.random() * 7;
                if (listSprite[x1][y1] != null) {
                    listSprite[x1][y1].idBase = ++numberNextBase.nextBase;
                    listSprite[x1][y1].isSetIntRandom = true;
                    FindPath(listSprite[x1][y1], x1, y1, numberNextBase);
                    break;
                }
            }
            if (numberNextBase.nextBase == 36) {
                break;
            }
        }
        listSprite[x1][y1].setText(listSprite[x1][y1].idBase);
        listSprite[x1][y1].isFillNumber = true;
        listSprite[x1][y1].isNumberSuggest = true;
        listSprite[x1][y1].id = listSprite[x1][y1].idBase;
        var corTran:ColorTransform = new ColorTransform();
        corTran.color = 0xFF8659;
        listSprite[x1][y1].colorBase = corTran;
        listSprite[x1][y1].shape.transform.colorTransform = listSprite[x1][y1].colorBase;
        listSprite[x1][y1] .sprite.removeEventListener(MouseEvent.MOUSE_OUT, onMouseOutCircle);
        var temp:int = 0;
        while (true) {
            var x:int = Math.random() * 7;
            var y:int = Math.random() * 7;
            if (listSprite[x][y] != null && listSprite[x][y].isFillNumber == false) {
                listSprite[x][y].setText(listSprite[x][y].idBase);
                listSprite[x][y].isFillNumber = true;
                listSprite[x][y].isNumberSuggest = true;
                listSprite[x][y].id = listSprite[x][y].idBase;
                var corTran:ColorTransform = new ColorTransform();
                corTran.color = 0xFF8659;
                listSprite[x][y].colorBase = corTran;
                listSprite[x][y].shape.transform.colorTransform = listSprite[x][y].colorBase;
                listSprite[x][y].sprite.removeEventListener(MouseEvent.MOUSE_OUT, onMouseOutCircle);
                temp++;
                if (temp == 10) {
                    break;
                }
            }
        }
        for (var i:int = 0; i < 7; i++) {
            for (var j:int = 0; j < 7; j++) {
                if (listSprite[i][j] != null) {
                    trace(listSprite[i][j].id);
                }
            }
        }
        var tempPlus = 1;
        while (true) {
            tempPlus++;
            if (tempPlus == 37 || checkBoard(tempPlus) == false) break;
        }
        nextNumber = tempPlus;
        txtNextNumber.text = nextNumber.toString();
        isPlusType = true;
        switchCheck = !switchCheck;
    }

    private function FindPath(cir:CirlcleData, i:int, j:int, numberNextBase:NumberBaseData):void {
        var templist:Array = new Array();
        if (listSprite[i][j - 1] != null && listSprite[i][j - 1].isSetIntRandom == false) {
            listSprite[i][j - 1].x = i;
            listSprite[i][j - 1].y = j - 1;
            templist.push(listSprite[i][j - 1]);
        }
        if (listSprite[i][j + 1] != null && listSprite[i][j + 1].isSetIntRandom == false) {
            listSprite[i][j + 1].x = i;
            listSprite[i][j + 1].y = j + 1;
            templist.push(listSprite[i][j + 1]);
        }
        if (i < 3) {

            if (i - 1 >= 0 && i - 1 < 7 && j - 1 >= 0 && j - 1 < 7 && listSprite[i - 1][j - 1] != null) {
                if (listSprite[i - 1][j - 1].isSetIntRandom == false) {
                    listSprite[i - 1][j - 1].x = i - 1;
                    listSprite[i - 1][j - 1].y = j - 1;
                    templist.push(listSprite[i - 1][j - 1]);
                }
            }
            if (i - 1 >= 0 && i - 1 < 7 && j >= 0 && j < 7 && listSprite[i - 1][j] != null && listSprite[i - 1][j].isSetIntRandom == false) {
                listSprite[i - 1][j].x = i - 1;
                listSprite[i - 1][j].y = j;
                templist.push(listSprite[i - 1][j]);
            }
            if (i + 1 >= 0 && i + 1 < 7 && j >= 0 && j < 7 && listSprite[i + 1][j] != null && listSprite[i + 1][j].isSetIntRandom == false) {
                listSprite[i + 1][j].x = i + 1;
                listSprite[i + 1][j].y = j;
                templist.push(listSprite[i + 1][j]);
            }
            if (i + 1 >= 0 && i + 1 < 7 && j + 1 >= 0 && j + 1 < 7 && listSprite[i + 1][j + 1] != null && listSprite[i + 1][j + 1].isSetIntRandom == false) {
                listSprite[i + 1][j + 1].x = i + 1;
                listSprite[i + 1][j + 1].y = j + 1;
                templist.push(listSprite[i + 1][j + 1]);
            }
        } else {
            if (i == 3) {
                if (listSprite[i - 1][j - 1] != null && listSprite[i - 1][j - 1].isSetIntRandom == false) {
                    listSprite[i - 1][j - 1].x = i - 1;
                    listSprite[i - 1][j - 1].y = j - 1;
                    templist.push(listSprite[i - 1][j - 1]);
                }
                if (listSprite[i + 1][j] != null && listSprite[i + 1][j].isSetIntRandom == false) {
                    listSprite[i + 1][j].x = i + 1;
                    listSprite[i + 1][j].y = j;
                    templist.push(listSprite[i + 1][j]);
                }
                if (listSprite[i + 1][j - 1] != null && listSprite[i + 1][j - 1].isSetIntRandom == false) {
                    listSprite[i + 1][j - 1].x = i + 1;
                    listSprite[i + 1][j - 1].y = j - 1;
                    templist.push(listSprite[i + 1][j - 1]);
                }
                if (listSprite[i + 1][j] != null && listSprite[i + 1][j].isSetIntRandom == false) {
                    listSprite[i + 1][j].x = i + 1;
                    listSprite[i + 1][j].y = j;
                    templist.push(listSprite[i + 1][j]);
                }
            } else {
                if (i + 1 >= 0 && i + 1 < 7 && j >= 0 && j < 7 && listSprite[i + 1][j] != null && listSprite[i + 1][j].isSetIntRandom == false) {
                    listSprite[i + 1][j].x = i + 1;
                    listSprite[i + 1][j].y = j;
                    templist.push(listSprite[i + 1][j]);
                }
                if (i - 1 >= 0 && i - 1 < 7 && j - 1 >= 0 && j - 1 < 7 && listSprite[i - 1][j + 1] != null && listSprite[i - 1][j + 1].isSetIntRandom == false) {
                    listSprite[i - 1][j + 1].x = i - 1;
                    listSprite[i - 1][j + 1].y = j + 1;
                    templist.push(listSprite[i - 1][j + 1]);
                }
                if (i + 1 >= 0 && i + 1 < 7 && j - 1 >= 0 && j - 1 < 7 && listSprite[i + 1][j - 1] != null && listSprite[i + 1][j - 1].isSetIntRandom == false) {
                    listSprite[i + 1][j - 1].x = i + 1;
                    listSprite[i + 1][j - 1].y = j - 1;
                    templist.push(listSprite[i + 1][j - 1]);
                }
                if (i + 1 >= 0 && i + 1 < 7 && j >= 0 && j < 7 && listSprite[i + 1][j] != null && listSprite[i + 1][j].isSetIntRandom == false) {
                    listSprite[i + 1][j].x = i + 1;
                    listSprite[i + 1][j].y = j;
                    templist.push(listSprite[i + 1][j]);
                }
            }
        }
        if (templist.length > 0) {
            var random:int = Math.random() * templist.length;
            templist[random].idBase = ++numberNextBase.nextBase;
            templist[random].isSetIntRandom = true;
            FindPath(templist[random], templist[random].x, templist[random].y, numberNextBase);
        } else {
            return;
        }

    }

    public function drawHex( a:int, b:int):Shape{
        var myShape:Shape = new Shape();
        var size: int = 23;
        var pointA:Point = new Point(0,0);
        myShape.graphics.moveTo(pointy_hex_corner(pointA,size,0).x, pointy_hex_corner(pointA,size,0).y);
        myShape.graphics.beginFill(0xFFF888);
        for (var i:int = 0; i <7; i++){
            myShape.graphics.lineStyle(2, 0xFF888B);
            myShape.graphics.lineTo(pointy_hex_corner(pointA,size,i).x, pointy_hex_corner(pointA, size, i).y);
            addChild(myShape);
        }
        myShape.graphics.endFill();
        myShape.x=a;
        myShape.y=b;
        var cortran:ColorTransform =new ColorTransform();cortran.color=0xBAF6F7;
        myShape.transform.colorTransform=cortran;
        return myShape;
    }

    private function onShapeDown(event:MouseEvent):void {
        trace("Down");
    }
    public function pointy_hex_corner(center, size, i):Point {
        var angle_deg = 60 * i - 30;
        var angle_rad = Math.PI / 180 * angle_deg;
        return new Point(center.x + size * Math.cos(angle_rad), center.y + size * Math.sin(angle_rad))
    }

}
}