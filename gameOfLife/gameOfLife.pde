int radius = 8;
int width = 1000;
int height = 1000;
int[][] cellsStep0 = new int[width / radius - 1][height / radius - 1];
int[][] cellsStep1 = new int[width / radius - 1][height / radius - 1];
int minX = 0;
int minY = 0;
int maxX = width / radius - 2;
int maxY = height / radius - 2;
int neighbours;
boolean launched;
boolean pause;

void setup()
{
    stroke(255);
    frameRate(15);
    size(width, height);
    background(255);
    launched = false;
    pause = false;

    //randomly define alive cells
    for (int i = 0 ; i <= maxX ; i ++ ) {
        for (int j = 0 ; j <= maxY ; j ++ ) {
            float r = random(10);
            if (r > 5) {
                cellsStep0[i][j] = 1;
            }
            else {
                cellsStep0[i][j] = 0;
            }
        }
    }
}

void draw()
{
    if (launched) {
        //set new state of the cells
        //foreach cell
        for (int j = minY ; j <= maxY ; j ++) {
            for (int i = minX ; i <= maxX ; i ++) {
                //define if the current cell is alive, dead or unchanged
                neighbours = getNumberOfNeighbours(i, j);
                if (neighbours == 3) {
                    cellsStep1[i][j] = 1;
                }
                else if (neighbours != 2) {
                    cellsStep1[i][j] = 0;
                }
                else {
                    cellsStep1[i][j] = cellsStep0[i][j];
                }
            }
        }

        //display them
        refreshDisplay(cellsStep1);
        cellsStep0 = cellsStep1;
        cellsStep1 = new int[width / radius - 1][height / radius - 1];
    }
}


void refreshDisplay(int[][] cells)
{
int posX;
int posY;

for (int j = minY ; j <= maxY ; j ++) {
    for (int i = minX ; i <= maxX ; i ++) {
        posX = i * radius - radius / 2;
        posY = j * radius - radius / 2;

        if (cells[i][j] == 1) {
            fill(0);
        }
        else {
            fill(255);
        }
            ellipse(posX, posY, radius, radius);
        }
    }
}

int getNumberOfNeighbours(int i, int j)
{
    int ret = 0;

    for (int x = -1 ; x < 2 ; x ++ ) {
        for (int y = -1 ; y < 2 ; y ++ ) {
            int xPos = x + i;
            int yPos = y + j;
            if (!(x == 0 && y == 0) && xPos > 0 && xPos <= maxX && yPos > 0 && yPos <= maxY) {
                ret += cellsStep0[xPos][yPos];
            }
        }
    }
    return ret;
}

void keyPressed()
{
    if (key == 'r') {
        setup();
    }
    else if (key == '\n') {
        launched = true;
    }
    else if (key == 'p') {
        if (pause) {
            pause = false;
            loop();
        }
        else {
            pause = true;
            noLoop();
        }
    }
}

void mousePressed()
{
    int xPos = ceil(mouseX / radius);
    int yPos = ceil(mouseY / radius);
    if (xPos < width / radius - 1 && yPos < height / radius - 1) {
        if (cellsStep1[xPos][yPos] == 1) {
            cellsStep1[xPos][yPos] = 0;
        }
        else {
            cellsStep1[xPos][yPos] = 1;
        }
    }
}

