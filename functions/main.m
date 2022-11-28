% Main program
clc
clear 
close all

%% Inputs
% Input options:
OSU = [372 373 374 384 385 386 396 397 398 408 409 410 420 421 422 432 433 434];    % NREL/OSU experiment #, M = 0.075                
% OSU = [375 376 377 387 388 389 399 400 401 411 412 413 423 424 425 435 436 437];  % NREL/OSU experiment #, M = 0.100
% OSU = [378 379 380 390 391 392 402 403 404 414 415 416 426 427 428 438 439 440];  % NREL/OSU experiment #, M = 0.125
% OSU = [381 382 383 393 394 395 405 406 407 417 418 419 429 430 431 441 442 443];  % NREL/OSU experiment #, M = 0.150
% OSU = 374;
other = 3:7;                                                                        % Saved reference case from other sources
% Select source as "OSU" or "other" 
INPUTS.source = "OSU";
% Select model ("BL" is available)
INPUTS.model = "BL";
% Plotting separate figures option
INPUTS.plot_sep_figs = 0; 
INPUTS.save_folder = pwd;
INPUTS.figures_extension = '.pdf';

%% Call solver
call_solver;