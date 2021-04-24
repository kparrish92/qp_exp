#!/usr/bin/env python
# -*- coding: utf-8 -*-
"""
This experiment was created using PsychoPy3 Experiment Builder (v2020.2.3),
    on October 21, 2020, at 16:18
If you publish work using this script the most relevant publication is:

    Peirce J, Gray JR, Simpson S, MacAskill M, Höchenberger R, Sogo H, Kastman E, Lindeløv JK. (2019) 
        PsychoPy2: Experiments in behavior made easy Behav Res 51: 195. 
        https://doi.org/10.3758/s13428-018-01193-y

"""

from __future__ import absolute_import, division

from psychopy import locale_setup
from psychopy import prefs
from psychopy import sound, gui, visual, core, data, event, logging, clock
from psychopy.constants import (NOT_STARTED, STARTED, PLAYING, PAUSED,
                                STOPPED, FINISHED, PRESSED, RELEASED, FOREVER)

import numpy as np  # whole numpy lib is available, prepend 'np.'
from numpy import (sin, cos, tan, log, log10, pi, average,
                   sqrt, std, deg2rad, rad2deg, linspace, asarray)
from numpy.random import random, randint, normal, shuffle
import os  # handy system and path functions
import sys  # to get file system encoding

from psychopy.hardware import keyboard



# Ensure that relative paths start from the same directory as this script
_thisDir = os.path.dirname(os.path.abspath(__file__))
os.chdir(_thisDir)

# Store info about the experiment session
psychopyVersion = '2020.2.3'
expName = 'pa_ba'  # from the Builder filename that created this script
expInfo = {'participant': '', 'session': '001'}
dlg = gui.DlgFromDict(dictionary=expInfo, sort_keys=False, title=expName)
if dlg.OK == False:
    core.quit()  # user pressed cancel
expInfo['date'] = data.getDateStr()  # add a simple timestamp
expInfo['expName'] = expName
expInfo['psychopyVersion'] = psychopyVersion

# Data file name stem = absolute path + name; later add .psyexp, .csv, .log, etc
filename = _thisDir + os.sep + u'data/%s_%s_%s' % (expInfo['participant'], expName, expInfo['date'])

# An ExperimentHandler isn't essential but helps with data saving
thisExp = data.ExperimentHandler(name=expName, version='',
    extraInfo=expInfo, runtimeInfo=None,
    originPath='C:\\Users\\gallo\\Desktop\\qp_exp\\exp\\pa_ba_lastrun.py',
    savePickle=True, saveWideText=True,
    dataFileName=filename)
# save a log file for detail verbose info
logFile = logging.LogFile(filename+'.log', level=logging.EXP)
logging.console.setLevel(logging.WARNING)  # this outputs to the screen, not a file

endExpNow = False  # flag for 'escape' or other condition => quit the exp
frameTolerance = 0.001  # how close to onset before 'same' frame

# Start Code - component code to be run before the window creation

# Setup the Window
win = visual.Window(
    size=(1024, 768), fullscr=True, screen=0, 
    winType='pyglet', allowGUI=False, allowStencil=False,
    monitor='testMonitor', color=[0,0,0], colorSpace='rgb',
    blendMode='avg', useFBO=True, 
    units='height')
# store frame rate of monitor if we can measure it
expInfo['frameRate'] = win.getActualFrameRate()
if expInfo['frameRate'] != None:
    frameDur = 1.0 / round(expInfo['frameRate'])
else:
    frameDur = 1.0 / 60.0  # could not measure, so guess

# create a default keyboard (e.g. to check for escape)
defaultKeyboard = keyboard.Keyboard()

# Initialize components for Routine "pa_ba"
pa_baClock = core.Clock()
cross_tr_2 = visual.TextStim(win=win, name='cross_tr_2',
    text='+',
    font='Arial',
    pos=(0, 0), height=0.1, wrapWidth=None, ori=0, 
    color='red', colorSpace='rgb', opacity=1, 
    languageStyle='LTR',
    depth=0.0);
sound_2 = sound.Sound('A', secs=-1, stereo=True, hamming=False,
    name='sound_2')
sound_2.setVolume(1)
resp_2 = keyboard.Keyboard()
pa = visual.TextStim(win=win, name='pa',
    text='pafri',
    font='Arial',
    pos=[-0.4, -0.2], height=0.1, wrapWidth=None, ori=0, 
    color='white', colorSpace='rgb', opacity=1, 
    languageStyle='LTR',
    depth=-3.0);
ba = visual.TextStim(win=win, name='ba',
    text='bafri',
    font='Arial',
    pos=[0.4, -0.2], height=0.1, wrapWidth=None, ori=0, 
    color='white', colorSpace='rgb', opacity=1, 
    languageStyle='LTR',
    depth=-4.0);

# Create some handy timers
globalClock = core.Clock()  # to track the time since experiment started
routineTimer = core.CountdownTimer()  # to track time remaining of each (non-slip) routine 

# set up handler to look after randomisation of conditions etc
trials = data.TrialHandler(nReps=5, method='random', 
    extraInfo=expInfo, originPath=-1,
    trialList=data.importConditions('cond_2.xlsx'),
    seed=None, name='trials')
thisExp.addLoop(trials)  # add the loop to the experiment
thisTrial = trials.trialList[0]  # so we can initialise stimuli with some values
# abbreviate parameter names if possible (e.g. rgb = thisTrial.rgb)
if thisTrial != None:
    for paramName in thisTrial:
        exec('{} = thisTrial[paramName]'.format(paramName))

for thisTrial in trials:
    currentLoop = trials
    # abbreviate parameter names if possible (e.g. rgb = thisTrial.rgb)
    if thisTrial != None:
        for paramName in thisTrial:
            exec('{} = thisTrial[paramName]'.format(paramName))
    
    # ------Prepare to start Routine "pa_ba"-------
    continueRoutine = True
    # update component parameters for each repeat
    sound_2.setSound(stimuli, hamming=False)
    sound_2.setVolume(1, log=False)
    resp_2.keys = []
    resp_2.rt = []
    _resp_2_allKeys = []
    # keep track of which components have finished
    pa_baComponents = [cross_tr_2, sound_2, resp_2, pa, ba]
    for thisComponent in pa_baComponents:
        thisComponent.tStart = None
        thisComponent.tStop = None
        thisComponent.tStartRefresh = None
        thisComponent.tStopRefresh = None
        if hasattr(thisComponent, 'status'):
            thisComponent.status = NOT_STARTED
    # reset timers
    t = 0
    _timeToFirstFrame = win.getFutureFlipTime(clock="now")
    pa_baClock.reset(-_timeToFirstFrame)  # t0 is time of first possible flip
    frameN = -1
    
    # -------Run Routine "pa_ba"-------
    while continueRoutine:
        # get current time
        t = pa_baClock.getTime()
        tThisFlip = win.getFutureFlipTime(clock=pa_baClock)
        tThisFlipGlobal = win.getFutureFlipTime(clock=None)
        frameN = frameN + 1  # number of completed frames (so 0 is the first frame)
        # update/draw components on each frame
        
        # *cross_tr_2* updates
        if cross_tr_2.status == NOT_STARTED and tThisFlip >= 0.0-frameTolerance:
            # keep track of start time/frame for later
            cross_tr_2.frameNStart = frameN  # exact frame index
            cross_tr_2.tStart = t  # local t and not account for scr refresh
            cross_tr_2.tStartRefresh = tThisFlipGlobal  # on global time
            win.timeOnFlip(cross_tr_2, 'tStartRefresh')  # time at next scr refresh
            cross_tr_2.setAutoDraw(True)
        if cross_tr_2.status == STARTED:
            # is it time to stop? (based on global clock, using actual start)
            if tThisFlipGlobal > cross_tr_2.tStartRefresh + .4-frameTolerance:
                # keep track of stop time/frame for later
                cross_tr_2.tStop = t  # not accounting for scr refresh
                cross_tr_2.frameNStop = frameN  # exact frame index
                win.timeOnFlip(cross_tr_2, 'tStopRefresh')  # time at next scr refresh
                cross_tr_2.setAutoDraw(False)
        # start/stop sound_2
        if sound_2.status == NOT_STARTED and tThisFlip >= .5-frameTolerance:
            # keep track of start time/frame for later
            sound_2.frameNStart = frameN  # exact frame index
            sound_2.tStart = t  # local t and not account for scr refresh
            sound_2.tStartRefresh = tThisFlipGlobal  # on global time
            sound_2.play(when=win)  # sync with win flip
        
        # *resp_2* updates
        waitOnFlip = False
        if resp_2.status == NOT_STARTED and tThisFlip >= 0.5-frameTolerance:
            # keep track of start time/frame for later
            resp_2.frameNStart = frameN  # exact frame index
            resp_2.tStart = t  # local t and not account for scr refresh
            resp_2.tStartRefresh = tThisFlipGlobal  # on global time
            win.timeOnFlip(resp_2, 'tStartRefresh')  # time at next scr refresh
            resp_2.status = STARTED
            # keyboard checking is just starting
            waitOnFlip = True
            win.callOnFlip(resp_2.clock.reset)  # t=0 on next screen flip
            win.callOnFlip(resp_2.clearEvents, eventType='keyboard')  # clear events on next screen flip
        if resp_2.status == STARTED and not waitOnFlip:
            theseKeys = resp_2.getKeys(keyList=['left', 'right'], waitRelease=False)
            _resp_2_allKeys.extend(theseKeys)
            if len(_resp_2_allKeys):
                resp_2.keys = _resp_2_allKeys[-1].name  # just the last key pressed
                resp_2.rt = _resp_2_allKeys[-1].rt
                # a response ends the routine
                continueRoutine = False
        
        # *pa* updates
        if pa.status == NOT_STARTED and tThisFlip >= .5-frameTolerance:
            # keep track of start time/frame for later
            pa.frameNStart = frameN  # exact frame index
            pa.tStart = t  # local t and not account for scr refresh
            pa.tStartRefresh = tThisFlipGlobal  # on global time
            win.timeOnFlip(pa, 'tStartRefresh')  # time at next scr refresh
            pa.setAutoDraw(True)
        
        # *ba* updates
        if ba.status == NOT_STARTED and tThisFlip >= .5-frameTolerance:
            # keep track of start time/frame for later
            ba.frameNStart = frameN  # exact frame index
            ba.tStart = t  # local t and not account for scr refresh
            ba.tStartRefresh = tThisFlipGlobal  # on global time
            win.timeOnFlip(ba, 'tStartRefresh')  # time at next scr refresh
            ba.setAutoDraw(True)
        
        # check for quit (typically the Esc key)
        if endExpNow or defaultKeyboard.getKeys(keyList=["escape"]):
            core.quit()
        
        # check if all components have finished
        if not continueRoutine:  # a component has requested a forced-end of Routine
            break
        continueRoutine = False  # will revert to True if at least one component still running
        for thisComponent in pa_baComponents:
            if hasattr(thisComponent, "status") and thisComponent.status != FINISHED:
                continueRoutine = True
                break  # at least one component has not yet finished
        
        # refresh the screen
        if continueRoutine:  # don't flip if this routine is over or we'll get a blank screen
            win.flip()
    
    # -------Ending Routine "pa_ba"-------
    for thisComponent in pa_baComponents:
        if hasattr(thisComponent, "setAutoDraw"):
            thisComponent.setAutoDraw(False)
    trials.addData('cross_tr_2.started', cross_tr_2.tStartRefresh)
    trials.addData('cross_tr_2.stopped', cross_tr_2.tStopRefresh)
    sound_2.stop()  # ensure sound has stopped at end of routine
    trials.addData('sound_2.started', sound_2.tStartRefresh)
    trials.addData('sound_2.stopped', sound_2.tStopRefresh)
    # check responses
    if resp_2.keys in ['', [], None]:  # No response was made
        resp_2.keys = None
    trials.addData('resp_2.keys',resp_2.keys)
    if resp_2.keys != None:  # we had a response
        trials.addData('resp_2.rt', resp_2.rt)
    trials.addData('resp_2.started', resp_2.tStartRefresh)
    trials.addData('resp_2.stopped', resp_2.tStopRefresh)
    trials.addData('pa.started', pa.tStartRefresh)
    trials.addData('pa.stopped', pa.tStopRefresh)
    trials.addData('ba.started', ba.tStartRefresh)
    trials.addData('ba.stopped', ba.tStopRefresh)
    # the Routine "pa_ba" was not non-slip safe, so reset the non-slip timer
    routineTimer.reset()
    thisExp.nextEntry()
    
# completed 5 repeats of 'trials'


# Flip one final time so any remaining win.callOnFlip() 
# and win.timeOnFlip() tasks get executed before quitting
win.flip()

# these shouldn't be strictly necessary (should auto-save)
thisExp.saveAsWideText(filename+'.csv', delim='auto')
thisExp.saveAsPickle(filename)
logging.flush()
# make sure everything is closed down
thisExp.abort()  # or data files will save again on exit
win.close()
core.quit()
