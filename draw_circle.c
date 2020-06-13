#include <stdio.h>
#include <stdbool.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>

/*
void curve(char** grid) {
	int cursorX = vector + centerX;
	int cursorY = vector + centerY;
	int drawNum = 2;
	while (cursorY != centerY) {
		for (int x = 0; x < 2; x++) {
			cursorX++;
			for (int i = 0; i < drawNum; i++) {
				if (cursorY == centerY) break;
				cursorY--;
				grid[cursorY][cursorX] = ' ';
			}
		}
		drawNum *= coeff;
	}
}
*/

void square(char** grid, int centerX, int centerY, int radius) {

	// Calculate the diagonal radius
	//  a^2 + b^2 = c^2;
	//  2a^2 = c^2;
	int diagonal = (radius * radius);
	printf("%d\n", diagonal);
	diagonal /= 2;
	printf("%d\n", diagonal);
	diagonal = sqrt(diagonal);
	printf("%d\n", diagonal);

	int cursor = diagonal;

	// Mark center
	grid[centerY][centerX] = ' ';
	

	// Apply radius directly on each cardinal direction
	grid[centerY][centerX + radius] = ' ';
	grid[centerY + radius][centerX] = ' ';
	grid[centerY][centerX - radius] = ' ';
	grid[centerY - radius][centerX] = ' ';

	// and every diagonal direction
	grid[centerY + diagonal][centerX + diagonal] = ' ';
	grid[centerY + diagonal][centerX - diagonal] = ' ';
	grid[centerY - diagonal][centerX + diagonal] = ' ';
	grid[centerY - diagonal][centerX - diagonal] = ' ';

	// The center, for good measure
	grid[centerY + diagonal][centerX + diagonal] = ' ';

	float coeff = 3.14159265 / 2;

	int cursorX, cursorY, cursorX2, cursorY2;
	cursorX = cursorX2 = vector + centerX;
	cursorY = cursorY2 = vector + centerY;
	int drawNum = 2;
	while (cursorY != centerY) {
		for (int x = 0; x < 2; x++) {
		cursorX++;
		cursorY2++;
		for (int i = 0; i < drawNum; i++) {
			if (cursorY == centerY) break;
			cursorY--;
			cursorX2--;
			grid[cursorY][cursorX] = ' ';
			grid[cursorY2][cursorX2] = ' ';
		}
		}
		drawNum *= coeff;
	}

	cursorX = cursorX2 = centerX + vector;
	cursorY = cursorY2 = centerY - vector;
	drawNum = 2;
	while (cursorY != centerY) {
		for (int x = 0; x < 2; x++) {
		cursorX++;
		cursorY2--;
		for (int i = 0; i < drawNum; i++) {
			if (cursorY == centerY) break;
			cursorY++;
			cursorX2--;
			grid[cursorY][cursorX] = ' ';
			grid[cursorY2][cursorX2] = ' ';
		}
		}
		drawNum *= coeff;
	}

	cursorX = cursorX2 = centerX - vector;
	cursorY = cursorY2 = centerY - vector;
	drawNum = 2;
	while (cursorY != centerY) {
		for (int x = 0; x < 2; x++) {
		cursorX--;
		cursorY2--;
		for (int i = 0; i < drawNum; i++) {
			if (cursorY == centerY) break;
			cursorY++;
			cursorX2++;
			grid[cursorY][cursorX] = ' ';
			grid[cursorY2][cursorX2] = ' ';
		}
		}
		drawNum *= coeff;
	}

	cursorX = cursorX2 = centerX - vector;
	cursorY = cursorY2 = centerY + vector;
	drawNum = 2;
	while (cursorY != centerY) {
		for (int x = 0; x < 2; x++) {
		cursorX--;
		cursorY2++;
		for (int i = 0; i < drawNum; i++) {
			if (cursorY == centerY) break;
			cursorY--;
			cursorX2++;
			grid[cursorY][cursorX] = ' ';
			grid[cursorY2][cursorX2] = ' ';
		}
		}
		drawNum *= coeff;
	}

	cursorX = cursorX2 = vector + centerX;
	cursorY = cursorY2 = vector + centerY;
	drawNum = 2;
	while (cursorY != centerY) {
		for (int x = 0; x < 2; x++) {
		cursorX++;
		cursorY2++;
		for (int i = 0; i < drawNum; i++) {
			if (cursorY == centerY) break;
			cursorY--;
			cursorX2--;
			grid[cursorY][cursorX] = ' ';
			grid[cursorY2][cursorX2] = ' ';
		}
		}
		drawNum *= coeff;
	}
}

int main(int argc, char** argv) {

	int radius;

	if (argc > 1) {
		radius = atoi(argv[1]);
		if (radius < 1 || radius > 200) radius = 9;
	} else {
		printf("Usage: ./draw_circle radius\n");
		printf("example:\n\n");

		radius = 10;
	}

	const int squareHeight = radius * 2 + 5;
	const int squareWidth = radius * 2 + 5;
	
	char** grid = malloc(squareHeight * sizeof(char*));
	for (int i = 0; i < squareHeight; i++) {
		grid[i] = malloc((squareWidth) * sizeof(char));
		for (int j = 0; j < squareWidth; j++) {
			grid[i][j] = 'X';
		}
	}

	square(grid, squareWidth/2, squareHeight/2, radius);
	for (int i = 0; i < squareHeight; i++) {
		for (int j = 0; j < squareWidth; j++) {
			// This is where I actually put two characters down for every square
			putchar(grid[i][j]);
			putchar(grid[i][j]);
		}
		putchar('\n');
	}
	return 0;
}
