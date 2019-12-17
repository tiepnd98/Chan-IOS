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
import flash.events.TimerEvent;
import flash.geom.ColorTransform;
import flash.net.registerClassAlias;
import flash.text.TextField;
import flash.events.MouseEvent;
import flash.text.TextFormat;
import flash.text.engine.TextElement;
import flash.ui.Mouse;
import flash.geom.Point;
import flash.utils.Timer;
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
    var nLevel:int=7;
    var rLevel:Number;
    var numShape=0;
    var n2:int=nLevel/2;
    public function Main() {
        loadGame();
    }
    private  function loadGame():void{
        loadBoard();
        timer();
        loadNextNumber();
        loadBase();
        var shapee:Shape=new Shape();
        shapee.graphics.moveTo(listSprite[0][0].sprite.x+listSprite[0][0].sprite.width/2,listSprite[0][0].sprite.y+listSprite[0][0].sprite.width/2);
        shapee.graphics.lineStyle(1, 0x000000);
        shapee.graphics.lineTo(listSprite[1][1].sprite.x+listSprite[0][0].sprite.width/2,listSprite[1][1].sprite.y+listSprite[0][0].sprite.width/2);
        addChild(shapee);
        var spritee:Sprite = new Sprite();
        spritee.graphics.clear();
        spritee.graphics.beginFill(0x00000, 1);
        spritee.graphics.drawEllipse((listSprite[0][0].sprite.x+listSprite[0][0].sprite.width/2+listSprite[1][1].sprite.x+listSprite[0][0].sprite.width/2)/2-5, (listSprite[0][0].sprite.y+listSprite[0][0].sprite.width/2+listSprite[1][1].sprite.y+listSprite[0][0].sprite.width/2)/2-5, 10, 10);
        spritee.graphics.endFill();
        //addChild(spritee)
        var myShape:Shape = new Shape();
        var size: int = 4;
        var pointA:Point = new Point(0,0);
        myShape.graphics.moveTo(pointy_hex_corner(pointA,size,0).x, pointy_hex_corner(pointA,size,0).y);
        myShape.graphics.beginFill(0x000000);
        for (var i:int = 0; i <7; i++){
            myShape.graphics.lineStyle(2, 0xFF888B);
            myShape.graphics.lineTo(pointy_hex_corner(pointA,size,i).x, pointy_hex_corner(pointA, size, i).y);
            addChild(myShape);
        }
        myShape.graphics.endFill();
        myShape.x=(listSprite[0][0].sprite.x+listSprite[0][0].sprite.width/2+listSprite[0][1].sprite.x+listSprite[0][0].sprite.width/2)/2;
        myShape.y=(listSprite[0][0].sprite.y+listSprite[0][0].sprite.width/2+listSprite[0][1].sprite.y+listSprite[0][0].sprite.width/2)/2;
        var cortran:ColorTransform =new ColorTransform();cortran.color=0xBAF6F7;
        myShape.transform.colorTransform=new ColorTransform(0xF0FF00);
    }
    var timerTextField:TextField = new TextField();
    public function timer():void{
        var delay:int = 1000; // in milliseconds
        var time:int =30; //in secs
        var myTimer:Timer = new Timer(delay, time);
        myTimer.addEventListener(TimerEvent.TIMER, onTimer);
        myTimer.addEventListener(TimerEvent.TIMER_COMPLETE, onComplete);
        myTimer.start();
        var tf:TextFormat = new TextFormat();
        tf.size = 20;
        tf.bold = true;
        tf.font = "Trebuchet MS"
        tf.color = 0x197791;
        tf.align="center";
        timerTextField.defaultTextFormat = tf;
        addChild(timerTextField);
        function onTimer(e: TimerEvent):void {
            if(startCheck()) {
                myTimer.stop();
            }
            else
            {
                timerTextField.text = String(Math.floor((myTimer.repeatCount - myTimer.currentCount) / 60)).substr(-2) + ":" + ("0" + ((myTimer.repeatCount - myTimer.currentCount) % 60)).substr(-2);         //Seconds
                timerTextField.x = 0;
                timerTextField.y = 0;
                addChild(timerTextField);
            }
        }
        function onComplete(e: TimerEvent):void{
            myTimer.reset();
            popupWin("Time Out!!!")
        }
    }

    private function loadNextNumber():void {
        var sprite:Sprite = new Sprite();
        sprite.graphics.clear();
        sprite.graphics.beginFill(0xFF4600, 0);
        sprite.graphics.drawEllipse(0, 0, 40, 40);
        sprite.graphics.endFill();
        sprite.x = width / 2 - 20-75;
        sprite.y = -50+5+50;
        drawHex( width / 2 - 20-75+20,-50+20+50).transform.colorTransform=new ColorTransform(0xF0FF00);

        var sprite1:Sprite = new Sprite();
        sprite1.graphics.clear();
        sprite1.graphics.beginFill(0xFF8E63, 1);
        sprite1.graphics.drawEllipse(0, 0, 30, 30);
        sprite1.x =width / 2 - 20 - 40-75;
        sprite1.y = -50 + 10+50;
        sprite1.graphics.endFill();
        sprite1.transform.colorTransform=new ColorTransform(0xF0FF00);
        var sprite2:Sprite = new Sprite();
        sprite2.graphics.clear();
        sprite2.graphics.beginFill(0xFF8E63, 1);
        sprite2.graphics.drawEllipse(0, 0, 30, 30);
        sprite2.x = width / 2 - 20 + 40 + 10-75;
        sprite2.y = -50 + 10+50;
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
            if (tempPlus == numShape || checkBoard(tempPlus) == false) break;
        }
        if(tempPlus<numShape){
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
        BG.graphics.beginFill(0xBAF6F7, 1);
        BG.graphics.drawRect(-100,-250,640,920);
        BG.graphics.endFill();
        addChild(BG);
        n2=nLevel/2;
        for (var i:int = 0; i < nLevel; i++) {
            var arr:Array = [];
            if (i <= n2) {
                for (var j:int = 0; j < n2 + 1 + i; j++) {
                    var circle:CirlcleData = new CirlcleData();
                    circle.shape=drawHex(-15+80 - 20 * i + 100 + 54 * j- 7*i,49 * i+20+75);
                    var sprite:Sprite = new Sprite();
                    sprite.graphics.clear();
                    sprite.graphics.beginFill(0xBAF6F7, 1);
                    sprite.graphics.drawEllipse(0, 0, 40, 40);
                    sprite.x = -15+60 - 20 * i + 100 + 54 * j - 7*i;
                    sprite.y = 49 * i+75;
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
                    numShape++;
                }
            } else {
                for (var j:int = 0; j < nLevel + n2 - i; j++) {
                    var circle:CirlcleData = new CirlcleData();
                    circle.shape=drawHex(-15+20 * (i-n2) + 100 + 54 * j+7*(i-n2),49 * i+20+75);
                    var sprite:Sprite = new Sprite();
                    sprite.graphics.clear();
                    sprite.graphics.beginFill(0xBAF6F7, 1);
                    sprite.graphics.drawEllipse(0, 0, 40, 40);
                    sprite.x = -15+20 * (i-n2) + 100 + 54 * j-20+7*(i-n2);
                    sprite.y = 49 * i+75;
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
                    numShape++;
                }
            }
            listSprite[i] = arr;

        }
        listSprite[n2][n2].setTextString("");
        listSprite[n2][n2].shape.transform.colorTransform = new ColorTransform(0xB6FF00,0xB6FF00,0xB6FF00 );
        (listSprite[n2][n2].sprite as Sprite).removeEventListener(MouseEvent.MOUSE_OUT, onMouseOutCircle);
        listSprite[n2][n2] = null;
    }

    private function onMouseOutCircle(event:MouseEvent):void {
        var corTran:ColorTransform = new ColorTransform();
        corTran.color = 0xBAF6F7;
     //   (event.currentTarget as Sprite).transform.colorTransform = corTran;

        for (var i:int = 0; i < nLevel; i++) {
            for (var j:int = 0; j < nLevel; j++) {
                if (listSprite[i][j] != null && listSprite[i][j].sprite == event.currentTarget) {
                    var corTran:ColorTransform = new ColorTransform();
                    corTran.color = 0xBAF6F7;
                    listSprite[i][j].shape.transform.colorTransform= new ColorTransform(0xF0FF00);
                }
            }
        }
    }

    private function onMouseMoveCircle(event:MouseEvent):void {
        for (var i:int = 0; i < nLevel; i++) {
            for (var j:int = 0; j <nLevel; j++) {
                if (listSprite[i][j] != null && listSprite[i][j].sprite == event.currentTarget) {
                  // (event.currentTarget as Sprite).transform.colorTransform = listSprite[i][j].colorBase;
                    listSprite[i][j].shape.transform.colorTransform = new ColorTransform(0xFF865);
                }
            }
        }
    }

    private function onMouseDownCircle(event:MouseEvent):void {
        for (var i:int = 0; i < nLevel; i++) {
            for (var j:int = 0; j < nLevel; j++) {
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
                    if (tempPlus == numShape || checkBoard(tempPlus) == false) break;
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
                if (tempPlus == numShape || checkBoard(tempPlus) == false) break;
            }
            if(tempPlus<numShape){
                nextNumber = tempPlus;
                txtNextNumber.text = nextNumber.toString();
                isPlusType = true;
                switchCheck = !switchCheck;
            }
        }
    }

    private function checkBoard(a:int):Boolean {
        for (var i:int = 0; i < nLevel; i++) {
            for (var j:int = 0; j < nLevel; j++) {
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
                key=tempPlus == numShape?numShape:0;
                if (tempPlus == numShape || checkBoard(tempPlus) == false){
                    break;
                }
            }
            if(tempPlus<numShape){
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
                        key=tempPlus == numShape?numShape:0;
                        if (tempPlus == numShape || checkBoard(tempPlus) == false){
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
                    key=tempPlus == numShape?numShape:0;
                    if (tempPlus == numShape || checkBoard(tempPlus) == false){
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

    private function popupWin( mess:String):void {
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
        var button:Sprite = new Sprite();
        function drawButton():void {
            button.graphics.clear();
            button.graphics.beginFill(0xD4D4D4); // grey color
            button.graphics.drawRoundRect(width/2-75-100, 450, 200, 45, 10, 10); // x, y, width, height, ellipseW, ellipseH
            button.graphics.endFill();
            var txtRestart:TextField = new TextField();
            tf.color=0xB90335;
            txtRestart.defaultTextFormat = tf;
            txtRestart.width = 200;
            txtRestart.height = 40;
            txtRestart.text = "Try Again!";
            txtRestart.y = 450;
            txtRestart.x = width/2-75-100;
            button.addChild(txtRestart);
        }
        function resetGameinPop(event:MouseEvent):void {
            button.x += 20
            if (button.x > 400) { button.x = 0}
            numShape=0;
            n2=nLevel/2;
            loadGame();
        }
        removeChild(timerTextField);
        button.graphics.clear();
        addChild(button);
        button.addEventListener(MouseEvent.MOUSE_DOWN, resetGameinPop);
        drawButton();
        addChild(capt);
    }
    private function resetGame(event:MouseEvent):void {
        removeChild(timerTextField);
        numShape=0;
        n2=nLevel/2;
        loadGame();
    }
    private function startCheck():Boolean {
        for (var i:int = 0; i < nLevel; i++) {
            for (var j:int = 0; j < nLevel; j++) {
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
        if(cir.id==numShape-1){
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
        if (i < n2) {

            if (i - 1 >= 0 && i - 1 < nLevel && j - 1 >= 0 && j - 1 < nLevel && listSprite[i - 1][j - 1] != null) {
                    listSprite[i - 1][j - 1].x = i - 1;
                    listSprite[i - 1][j - 1].y = j - 1;
                    templist.push(listSprite[i - 1][j - 1]);
            }
            if (i - 1 >= 0 && i - 1 < nLevel && j >= 0 && j < nLevel && listSprite[i - 1][j] != null ) {
                listSprite[i - 1][j].x = i - 1;
                listSprite[i - 1][j].y = j;
                templist.push(listSprite[i - 1][j]);
            }
            if (i + 1 >= 0 && i + 1 < nLevel && j >= 0 && j < nLevel && listSprite[i + 1][j] != null ) {
                listSprite[i + 1][j].x = i + 1;
                listSprite[i + 1][j].y = j;
                templist.push(listSprite[i + 1][j]);
            }
            if (i + 1 >= 0 && i + 1 < nLevel && j + 1 >= 0 && j + 1 < nLevel && listSprite[i + 1][j + 1] != null ) {
                listSprite[i + 1][j + 1].x = i + 1;
                listSprite[i + 1][j + 1].y = j + 1;
                templist.push(listSprite[i + 1][j + 1]);
            }
        } else {
            if (i == n2) {
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
                if (i + 1 >= 0 && i + 1 < nLevel && j >= 0 && j < nLevel && listSprite[i + 1][j] != null ) {
                    listSprite[i + 1][j].x = i + 1;
                    listSprite[i + 1][j].y = j;
                    templist.push(listSprite[i + 1][j]);
                }
                if (i - 1 >= 0 && i - 1 < nLevel && j + 1 >= 0 && j + 1 < nLevel && listSprite[i - 1][j + 1] != null ) {
                    listSprite[i - 1][j + 1].x = i - 1;
                    listSprite[i - 1][j + 1].y = j + 1;
                    templist.push(listSprite[i - 1][j + 1]);
                }
                if (i + 1 >= 0 && i + 1 < nLevel && j - 1 >= 0 && j - 1 < nLevel && listSprite[i + 1][j - 1] != null ) {
                    listSprite[i + 1][j - 1].x = i + 1;
                    listSprite[i + 1][j - 1].y = j - 1;
                    templist.push(listSprite[i + 1][j - 1]);
                }
                if (i - 1 >= 0 && i - 1 < nLevel && j >= 0 && j < nLevel && listSprite[i - 1][j] != null ) {
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
            for (var i:int = 0; i < nLevel; i++) {
                for (var j:int = 0; j < nLevel; j++) {
                    if (listSprite[i][j] != null) {
                        listSprite[i][j].isSetIntRandom = false;
                    }
                }
            }

            numberNextBase.nextBase = 0;
            while (true) {
                x1 = Math.random() * nLevel;
                y1 = Math.random() * nLevel;
                if (listSprite[x1][y1] != null) {
                    listSprite[x1][y1].idBase = ++numberNextBase.nextBase;
                    listSprite[x1][y1].isSetIntRandom = true;
                    FindPath(listSprite[x1][y1], x1, y1, numberNextBase);
                    break;
                }
            }
            trace(numberNextBase.nextBase);
            if (numberNextBase.nextBase == numShape-1) {
                break;
            }
        }
        listSprite[x1][y1].setText(listSprite[x1][y1].idBase);
        listSprite[x1][y1].isFillNumber = true;
        listSprite[x1][y1].isNumberSuggest = true;
        listSprite[x1][y1].id = listSprite[x1][y1].idBase;
        listSprite[x1][y1].colorBase = new ColorTransform(0xFF865);
        listSprite[x1][y1].shape.transform.colorTransform = listSprite[x1][y1].colorBase;
        listSprite[x1][y1] .sprite.removeEventListener(MouseEvent.MOUSE_OUT, onMouseOutCircle);
        var temp:int = 0;
        while (true) {
            var x:int = Math.random() * nLevel;
            var y:int = Math.random() * nLevel;
            if (listSprite[x][y] != null && listSprite[x][y].isFillNumber == false) {
                listSprite[x][y].setText(listSprite[x][y].idBase);
                listSprite[x][y].isFillNumber = true;
                listSprite[x][y].isNumberSuggest = true;
                listSprite[x][y].id = listSprite[x][y].idBase;
                listSprite[x][y].shape.transform.colorTransform = new ColorTransform(0xFF865);
                listSprite[x][y].sprite.removeEventListener(MouseEvent.MOUSE_OUT, onMouseOutCircle);
                temp++;
                if (temp == 10) {
                    break;
                }
            }
        }
        for (var i:int = 0; i < nLevel; i++) {
            for (var j:int = 0; j < nLevel; j++) {
                if (listSprite[i][j] != null) {
                    trace(listSprite[i][j].id);
                }
            }
        }
        var tempPlus = 1;
        while (true) {
            tempPlus++;
            if (tempPlus == numShape || checkBoard(tempPlus) == false) break;
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
        if (i < n2) {

            if (i - 1 >= 0 && i - 1 < nLevel && j - 1 >= 0 && j - 1 < nLevel && listSprite[i - 1][j - 1] != null) {
                if (listSprite[i - 1][j - 1].isSetIntRandom == false) {
                    listSprite[i - 1][j - 1].x = i - 1;
                    listSprite[i - 1][j - 1].y = j - 1;
                    templist.push(listSprite[i - 1][j - 1]);
                }
            }
            if (i - 1 >= 0 && i - 1 < nLevel && j >= 0 && j < nLevel && listSprite[i - 1][j] != null && listSprite[i - 1][j].isSetIntRandom == false) {
                listSprite[i - 1][j].x = i - 1;
                listSprite[i - 1][j].y = j;
                templist.push(listSprite[i - 1][j]);
            }
            if (i + 1 >= 0 && i + 1 < nLevel && j >= 0 && j < nLevel && listSprite[i + 1][j] != null && listSprite[i + 1][j].isSetIntRandom == false) {
                listSprite[i + 1][j].x = i + 1;
                listSprite[i + 1][j].y = j;
                templist.push(listSprite[i + 1][j]);
            }
            if (i + 1 >= 0 && i + 1 < nLevel && j + 1 >= 0 && j + 1 < nLevel && listSprite[i + 1][j + 1] != null && listSprite[i + 1][j + 1].isSetIntRandom == false) {
                listSprite[i + 1][j + 1].x = i + 1;
                listSprite[i + 1][j + 1].y = j + 1;
                templist.push(listSprite[i + 1][j + 1]);
            }
        } else {
            if (i == n2) {
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
                if (i + 1 >= 0 && i + 1 < nLevel && j >= 0 && j < nLevel && listSprite[i + 1][j] != null && listSprite[i + 1][j].isSetIntRandom == false) {
                    listSprite[i + 1][j].x = i + 1;
                    listSprite[i + 1][j].y = j;
                    templist.push(listSprite[i + 1][j]);
                }
                if (i - 1 >= 0 && i - 1 < nLevel && j - 1 >= 0 && j - 1 < nLevel && listSprite[i - 1][j + 1] != null && listSprite[i - 1][j + 1].isSetIntRandom == false) {
                    listSprite[i - 1][j + 1].x = i - 1;
                    listSprite[i - 1][j + 1].y = j + 1;
                    templist.push(listSprite[i - 1][j + 1]);
                }
                if (i + 1 >= 0 && i + 1 < nLevel && j - 1 >= 0 && j - 1 < nLevel && listSprite[i + 1][j - 1] != null && listSprite[i + 1][j - 1].isSetIntRandom == false) {
                    listSprite[i + 1][j - 1].x = i + 1;
                    listSprite[i + 1][j - 1].y = j - 1;
                    templist.push(listSprite[i + 1][j - 1]);
                }
                if (i + 1 >= 0 && i + 1 < nLevel && j >= 0 && j < nLevel && listSprite[i + 1][j] != null && listSprite[i + 1][j].isSetIntRandom == false) {
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
        var size: int = 28;
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
        myShape.transform.colorTransform=new ColorTransform(0xF0FF00);
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