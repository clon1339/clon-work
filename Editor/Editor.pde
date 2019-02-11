PrintWriter Output;
PFont myFont;
String dir = "data";
String name = "name.txt";
String txt = "";
String txtFront = "";
String txtBehind = "";
char Enter = 13;
var userAgent;

int focus = 0;
int NumOfTxt = 0;
int lineCount = 0;
String completed = "";
void setup() {
	userAgent = window.navigator.userAgent.toLowerCase();
  size(800, 600);
  background(50, 50, 50);
  frameRate(60);
  myFont = createFont("游ゴシック Medium", 27, true);
}

float txtLength() {
  String lineTxt = "";
  for (int i = txt.length() - 1; i >= 0; i--) {
    if (txt.charAt(i).match(/\r?\n/g)) {
      lineTxt = txt.substring(i, txt.length());
      return textWidth(lineTxt);
    }
  }
  return textWidth(txt);
}

void draw() {
  background(50, 50, 50);
  textFont(myFont);
  if ( focus == 0 ) {
    strokeWeight(2);
    stroke(255, 255, 255);
    fill(50, 50, 50);
    rect(20, 120, 760, 400);
    fill(255, 0, 0);
    text("保存ディレクトリ：" + dir, 20, 50);
    line(textWidth("保存ディレクトリ：" + dir) + 20, 20, textWidth("保存ディレクトリ：" + dir)+ 20, 50);
    fill(255);
    text("ファイル名：" + name, 20, 100);
    text(txt, 30, 160);
    stroke(255);
    fill(50);
    rect(580, 535, 200, 50);
    fill(255);
    text("保 存", 647, 570);
  }
  if ( focus == 1 ) {
    strokeWeight(2);
    stroke(255, 255, 255);
    fill(50, 50, 50);
    rect(20, 120, 760, 400);
    fill(255, 0, 0);
    text("ファイル名：" + name, 20, 100);
    line(textWidth("ファイル名：" + name) + 20, 70, textWidth("ファイル名：" + name)+ 20, 100);

    fill(255);
    text("保存ディレクトリ：" + dir, 20, 50);
    text(txt, 30, 160);
    stroke(255);
    fill(50);
    rect(580, 535, 200, 50);
    fill(255);
    text("保 存", 647, 570);
  }
  if ( focus == 2 ) {
		
		lineCount=(txt.match(/\r?\n/g) || '').length;
    text(lineCount, 700, 50);
    strokeWeight(2);
    stroke(255, 0, 0);
    fill(50, 50, 50);
    rect(20, 120, 760, 400);
    fill(255);
    text("保存ディレクトリ：" + dir, 20, 50);
    text("ファイル名：" + name, 20, 100);
    text(txt, 30, 160);
    stroke(255);
    line(txtLength() + 30, 130 + 44 * lineCount, txtLength()+ 30, 160 + 44 * lineCount);
    fill(50);
    rect(580, 535, 200, 50);
    fill(255);
    text("保 存", 647, 570);
  }
  if ( focus == 3 ) {
    strokeWeight(2);
    stroke(255);
    fill(50, 50, 50);
    rect(20, 120, 760, 400);
    fill(255);
    text("保存ディレクトリ：" + dir, 20, 50);
    text("ファイル名：" + name, 20, 100);
    text(txt, 30, 160);
    stroke(255, 0, 0);
    rect(580, 535, 200, 50);
    fill(255, 0, 0);
    text("保 存", 647, 570);
    text(completed, 50, 570);
  }
}

void keyPressed() {
	//println("Pressed:"+keyCode);
  completed = "";
  if ( keyCode == 38 && focus > 0) {
    focus -=1;
  }else if ( keyCode == 40 && focus < 3) {
    focus +=1;
  } else if ( focus == 0 && key != CODED) {
    if ( keyCode == 8 && dir.length() > 0) {
      dir = dir.substring(0, dir.length()-1);
    } else if (keyCode != 8 && keyCode != 10) {
      dir = dir + String.fromCharCode(key);
    }
  } else if ( focus == 1 && key != CODED) {
    if ( keyCode == 8 && name.length() > 0) {
      name = name.substring(0, name.length()-1);
    } else if (keyCode != 8 && keyCode != 10) {
      name = name + String.fromCharCode(key);
    }
  } else if ( focus == 2 && key != CODED) {
    if ( keyCode == 8 && txt.length() > 0) {
      txt = txt.substring(0, txt.length()-1);
    } else if (lineCount == 8 && keyCode == 10) {
      return;
    } else if (keyCode != 8) {
      txt = txt + String.fromCharCode(key);
      if (txtLength() >= 730) {
        txt = txt.substring(0, txt.length()-1);
      }
    }
  } else if ( focus == 3 && keyCode != 8) {
		const a = document.createElement('a');
		a.href = 'data:text/plain,' + encodeURIComponent(txt);
		a.download = name;

		a.style.display = 'none';
		document.body.appendChild(a);
		a.click();
		document.body.removeChild(a);
		
    completed = "保存しました。";
    return;
  }
}
document.onkeydown = function (event) {
 if ( focus == 0 && event.key != CODED) {
    if ( event.keyCode == 8 && dir.length() > 0) {
      dir = dir.substring(0, dir.length()-1);
    }
  } else if ( focus == 1 && event.key != CODED) {
    if ( event.keyCode == 8 && name.length() > 0) {
      name = name.substring(0, name.length()-1);
    } 
  } else if ( focus == 2 && event.key != CODED) {
    if ( event.keyCode == 8 && txt.length() > 0) {
      txt = txt.substring(0, txt.length()-1);
    }
  }
}