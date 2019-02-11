/* @pjs preload="TrumpCards6/png/x01.png,TrumpCards6/png/x02.png,TrumpCards6/png/z01.png,TrumpCards6/png/z02.png,TrumpCards6/png/0.png,TrumpCards6/png/1.png,TrumpCards6/png/2.png,TrumpCards6/png/3.png,TrumpCards6/png/4.png,TrumpCards6/png/5.png,TrumpCards6/png/6.png,TrumpCards6/png/7.png,TrumpCards6/png/8.png,TrumpCards6/png/9.png,TrumpCards6/png/10.png,TrumpCards6/png/11.png,TrumpCards6/png/12.png,TrumpCards6/png/13.png,TrumpCards6/png/14.png,TrumpCards6/png/15.png,TrumpCards6/png/16.png,TrumpCards6/png/17.png,TrumpCards6/png/18.png,TrumpCards6/png/19.png,TrumpCards6/png/20.png,TrumpCards6/png/21.png,TrumpCards6/png/22.png,TrumpCards6/png/23.png,TrumpCards6/png/24.png,TrumpCards6/png/25.png,TrumpCards6/png/26.png,TrumpCards6/png/27.png,TrumpCards6/png/28.png,TrumpCards6/png/29.png,TrumpCards6/png/30.png,TrumpCards6/png/31.png,TrumpCards6/png/32.png,TrumpCards6/png/33.png,TrumpCards6/png/34.png,TrumpCards6/png/35.png,TrumpCards6/png/36.png,TrumpCards6/png/37.png,TrumpCards6/png/38.png,TrumpCards6/png/39.png,TrumpCards6/png/40.png,TrumpCards6/png/41.png,TrumpCards6/png/42.png,TrumpCards6/png/43.png,TrumpCards6/png/44.png,TrumpCards6/png/45.png,TrumpCards6/png/46.png,TrumpCards6/png/47.png,TrumpCards6/png/48.png,TrumpCards6/png/49.png,TrumpCards6/png/50.png,TrumpCards6/png/51.png"; */


PFont myFont;
Card[] cards = new Card[52];
boolean[] cardsDraw = new boolean[52];
int frontCards = 0;
int cardsDifference = 0;
int cardsDrawFirst = 0;
int cardsDrawSecond = 0;
boolean restartGame = true;
int indexOfChosen = 0;
int indexOfTurn = 0;
int indexOfFindPair = 0;
String gameMode = "title";

void drawCards() 
{
  int k;
  k = floor(random(0, 52));
  if (cardsDraw[k] == false) 
  {
    cardsDraw[k] = true;
    for (int i = 0; i < 52; i++)
    {
      if (cards[i].isDrawCards == false)
      {
        cards[i].order = k;
        cards[i].isDrawCards = true;
        indexOfChosen ++;
        break;
      }
    }
  }
}


void setup() 
{
  size(1000, 600);
  background(255, 255, 255);
  fill(0, 0, 0);
  noStroke();
  frameRate(30);
  myFont = createFont("YuGothic", 24, true);
  textFont(myFont);
  for (int i = 0; i < 52; i++) 
  {
    cards[i] = new Card(loadImage("TrumpCards6/png/" + i + ".png"), loadImage("TrumpCards6/png/z02.png"));
    cardsDraw[i] = false;
  }
}


void draw() 
{
  if (gameMode == "title")
  {
    background(255);
    stroke(0);
    noFill();
    rectMode(CENTER);
    rect(width / 2, 450, 300, 70, 7);
    textAlign(CENTER);
    textSize(24);
    text("START GAME", width / 2, 450);
    textSize(50);
    text("神経衰弱", width / 2, 150);
    textSize(22);
    text("Rでリスタート", width / 2, 530);
    text("Cでクリア", width / 2, 560);
  }
  if (gameMode == "Pelmanism") 
  {
    background(80);
    if (restartGame)
    {
      drawCards();
    }
    for (int i = 0; i < 52; i++) 
    {
      if (cards[i].isDrawCards)
      {
        cards[i].xpos = (int)(cards[i].order % 13) * 76 + 11;
        cards[i].ypos = (int)(cards[i].order / 13) * 150 + 39;
      }
      if (cards[i].isLiveCards && cards[i].isDrawCards) 
      {
        cards[i].draw();
      }
    }
    if (indexOfChosen == 52)
    {
      restartGame = false;
    }
    if (indexOfFindPair == 26)
    {
      gameMode = "clearPelmanism";
    }
  }
  if (gameMode == "clearPelmanism")
  {
    background(255);
    stroke(0);
    noFill();
    rectMode(CENTER);
    rect(800, 440, 250, 60);
    textSize(50);
    text("クリア！おめでとう！！", width / 2, 300);
    textSize(24);
    text("タイトルへ戻る", 800, 450);
  }
}


class Card 
{
  PImage frontImg;
  PImage backImg;
  int xpos;
  int ypos;
  int scale = 3;
  int imgWidth;
  int imgHeight;
  int order;
  boolean isFront = false;
  boolean isLiveCards = true;
  boolean isDrawCards = false;



  Card(PImage _frontImg, PImage _backImg) 
  {
    frontImg = _frontImg;
    backImg = _backImg;
    imgWidth = frontImg.width / scale;
    imgHeight = frontImg.height / scale;
  }



  void setPos(int _x, int _y)
  {
    xpos = _x; 
    ypos = _y;
  }

  void draw() 
  {
    if (isFront) 
    {
      image(frontImg, xpos, ypos, imgWidth, imgHeight);
    } else
    {
      image(backImg, xpos, ypos, imgWidth, imgHeight);
    }
  }
}


void mouseClicked() 
{
  if (gameMode == "title")
  {
    if (mouseX > width / 2 - 150 && mouseX < width / 2 + 150 && mouseY > 415 && mouseY < 485)
    {
      gameMode = "Pelmanism";
      indexOfTurn = 0;
      indexOfFindPair = 0;
      indexOfChosen = 0;
      frontCards = 0;
      restartGame = true;
      for (int i = 0; i < 52; i++)
      {
        cards[i].isDrawCards = false;
        cards[i].isLiveCards = true;
        cards[i].isFront = false;
        cardsDraw[i] = false;
      }
    }
  }
  if (gameMode == "Pelmanism")
  {
    for (int i = 0; i < 52; i++) 
    {
      if (cards[i].isLiveCards && 
        cards[i].isFront == false &&
        frontCards < 2 &&
        !restartGame &&
        mouseX > cards[i].xpos && mouseX < cards[i].xpos + cards[i].imgWidth && mouseY > cards[i].ypos && mouseY < cards[i].ypos + cards[i].imgHeight) 
      {
        cards[i].isFront = !cards[i].isFront;
        frontCards ++;
        indexOfTurn ++;
        if (frontCards == 1) 
        {
          cardsDrawFirst = i;
        }

        if (frontCards == 2) 
        {
          cardsDrawSecond = i;
        }
        return;
      }


      if (frontCards == 2) 
      {
        cardsDifference = cardsDrawFirst - cardsDrawSecond;
        if (cardsDifference % 13 == 0) 
        {
          cards[cardsDrawFirst].isLiveCards = false;
          cards[cardsDrawSecond].isLiveCards = false;
          indexOfFindPair++;
        }

        for (int k = 0; k < 52; k++) 
        {
          cards[k].isFront = false;
          frontCards = 0;
          cardsDrawFirst = 0;
          cardsDrawSecond = 0;
        }
        return;
      }
    }
  }
  if (gameMode == "clearPelmanism")
  {
    if (mouseX > 675 && mouseX < 925 && mouseY > 410 && mouseY < 470)
    {
      gameMode = "title";
    }
  }
}

void keyPressed()
{
  if (key == 'r' && gameMode == "Pelmanism") 
  {
    restartGame = true;
    indexOfTurn = 0;
    indexOfFindPair = 0;
    indexOfChosen = 0;
    frontCards = 0;
    for (int i = 0; i < 52; i++)
    {
      cards[i].isDrawCards = false;
      cards[i].isLiveCards = true;
      cards[i].isFront = false;
      cardsDraw[i] = false;
    }
  }
  if (key == 'c')
  {
    gameMode = "clearPelmanism";
  }
}