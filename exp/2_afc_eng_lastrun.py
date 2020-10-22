#!/usr/bin/env python
# -*- coding: utf-8 -*-
"""
This experiment was created using PsychoPy3 Experiment Builder (v2020.2.3),
    on October 21, 2020, at 16:01
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
expName = '2_afc_eng'  # from the Builder filename that created this script
expInfo = {'session': '01', 'participant': ''}
dlg = gui.DlgFromDict(dictionary=expInfo, sort_keys=False, title=expName)
if dlg.OK == False:
    core.quit()  # user pressed cancel
expInfo['date'] = data.getDateStr()  # add a simple timestamp
expInfo['expName'] = expName
expInfo['psychopyVersion'] = psychopyVersion

# Data file name stem = absolute path + name; later add .psyexp, .csv, .log, etc
filename = _thisDir + os.sep + u'data' + os.sep + '%s_%s' % (expInfo['participant'], expInfo['date'])

# An ExperimentHandler isn't essential but helps with data saving
thisExp = data.ExperimentHandler(name=expName, version='',
    extraInfo=expInfo, runtimeInfo=None,
    originPath='C:\\Users\\gallo\\Desktop\\qp_exp\\2_afc_eng_lastrun.py',
    savePickle=True, saveWideText=True,
    dataFileName=filename)
# save a log file for detail verbose info
logFile = logging.LogFile(filename+'.log', level=logging.WARNING)
logging.console.setLevel(logging.WARNING)  # this outputs to the screen, not a file

endExpNow = False  # flag for 'escape' or other condition => quit the exp
frameTolerance = 0.001  # how close to onset before 'same' frame

# Start Code - component code to be run before the window creation

# Setup the Window
win = visual.Window(
    size=[2560, 1440], fullscr=True, screen=0, 
    winType='pyglet', allowGUI=False, allowStencil=False,
    monitor='testMonitor', color='black', colorSpace='rgb',
    blendMode='avg', useFBO=True, 
    units='norm')
# store frame rate of monitor if we can measure it
expInfo['frameRate'] = win.getActualFrameRate()
if expInfo['frameRate'] != None:
    frameDur = 1.0 / round(expInfo['frameRate'])
else:
    frameDur = 1.0 / 60.0  # could not measure, so guess

# create a default keyboard (e.g. to check for escape)
defaultKeyboard = keyboard.Keyboard()

# Initialize components for Routine "instruct"
instructClock = core.Clock()
instrText = visual.TextStim(win=win, name='instrText',
    text='Practice Instructions - use the left and right mouse key to answer.  You will hear the beginning of a rare word in English. Use the left or right mouse key to decide which word is beginning to be said. ',
    font='Arial',
    pos=[0, 0], height=0.1, wrapWidth=None, ori=0, 
    color=[1, 1, 1], colorSpace='rgb', opacity=1, 
    languageStyle='LTR',
    depth=0.0);
ready = keyboard.Keyboard()

# Initialize components for Routine "practice"
practiceClock = core.Clock()
cross_tr = visual.TextStim(win=win, name='cross_tr',
    text='+',
    font='Arial',
    pos=(0, 0), height=0.1, wrapWidth=None, ori=0, 
    color='red', colorSpace='rgb', opacity=1, 
    languageStyle='LTR',
    depth=0.0);
sound_1 = sound.Sound('A', secs=-1, stereo=True, hamming=False,
    name='sound_1')
sound_1.setVolume(1)
resp = keyboard.Keyboard()
eefree_p = visual.TextStim(win=win, name='eefree_p',
    text='eefree',
    font='Arial',
    pos=[-0.4, -0.2], height=0.1, wrapWidth=None, ori=0, 
    color='white', colorSpace='rgb', opacity=1, 
    languageStyle='LTR',
    depth=-3.0);
offree_practice = visual.TextStim(win=win, name='offree_practice',
    text='oofree\n',
    font='Arial',
    pos=[0.4, -0.25], height=0.1, wrapWidth=None, ori=0, 
    color='white', colorSpace='rgb', opacity=1, 
    languageStyle='LTR',
    depth=-4.0);

# Initialize components for Routine "got_it"
got_itClock = core.Clock()
gotIT = visual.TextStim(win=win, name='gotIT',
    text='Got it? If you have any questions please ask the experimenter now. If not, press the spacebar to begin the experiment. ',
    font='Arial',
    pos=(0, 0), height=0.08, wrapWidth=None, ori=0, 
    color='white', colorSpace='rgb', opacity=1, 
    languageStyle='LTR',
    depth=0.0);
gotResponse = keyboard.Keyboard()

# Initialize components for Routine "i_u"
i_uClock = core.Clock()
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
eefree_p_2 = visual.TextStim(win=win, name='eefree_p_2',
    text='eefree',
    font='Arial',
    pos=[-0.4, -0.2], height=0.1, wrapWidth=None, ori=0, 
    color='white', colorSpace='rgb', opacity=1, 
    languageStyle='LTR',
    depth=-3.0);
offree_practice_2 = visual.TextStim(win=win, name='offree_practice_2',
    text='oofree\n',
    font='Arial',
    pos=[0.4, -0.25], height=0.1, wrapWidth=None, ori=0, 
    color='white', colorSpace='rgb', opacity=1, 
    languageStyle='LTR',
    depth=-4.0);

# Initialize components for Routine "instruct_2"
instruct_2Clock = core.Clock()
instrText_2 = visual.TextStim(win=win, name='instrText_2',
    text='Part 2 - now the instructions are the same, but we have two new words.',
    font='Arial',
    pos=[0, 0], height=0.1, wrapWidth=None, ori=0, 
    color=[1, 1, 1], colorSpace='rgb', opacity=1, 
    languageStyle='LTR',
    depth=0.0);
ready_2 = keyboard.Keyboard()

# Initialize components for Routine "ba_pa"
ba_paClock = core.Clock()
cross_tr_3 = visual.TextStim(win=win, name='cross_tr_3',
    text='+',
    font='Arial',
    pos=(0, 0), height=0.1, wrapWidth=None, ori=0, 
    color='red', colorSpace='rgb', opacity=1, 
    languageStyle='LTR',
    depth=0.0);
sound_3 = sound.Sound('A', secs=-1, stereo=True, hamming=False,
    name='sound_3')
sound_3.setVolume(1)
resp_3 = keyboard.Keyboard()
pafri = visual.TextStim(win=win, name='pafri',
    text='pafri',
    font='Arial',
    pos=[-0.4, -0.2], height=0.1, wrapWidth=None, ori=0, 
    color='white', colorSpace='rgb', opacity=1, 
    languageStyle='LTR',
    depth=-3.0);
bafri = visual.TextStim(win=win, name='bafri',
    text='bafri',
    font='Arial',
    pos=[0.4, -0.2], height=0.1, wrapWidth=None, ori=0, 
    color='white', colorSpace='rgb', opacity=1, 
    languageStyle='LTR',
    depth=-4.0);

# Initialize components for Routine "thanks"
thanksClock = core.Clock()
thanksText = visual.TextStim(win=win, name='thanksText',
    text='This is the end of the experiment.\n\nThanks!',
    font='arial',
    pos=[0, 0], height=0.1, wrapWidth=None, ori=0, 
    color=[1, 1, 1], colorSpace='rgb', opacity=1, 
    languageStyle='LTR',
    depth=0.0);

# Create some handy timers
globalClock = core.Clock()  # to track the time since experiment started
routineTimer = core.CountdownTimer()  # to track time remaining of each (non-slip) routine 

# ------Prepare to start Routine "instruct"-------
continueRoutine = True
# update component parameters for each repeat
ready.keys = []
ready.rt = []
_ready_allKeys = []
# keep track of which components have finished
instructComponents = [instrText, ready]
for thisComponent in instructComponents:
    thisComponent.tStart = None
    thisComponent.tStop = None
    thisComponent.tStartRefresh = None
    thisComponent.tStopRefresh = None
    if hasattr(thisComponent, 'status'):
        thisComponent.status = NOT_STARTED
# reset timers
t = 0
_timeToFirstFrame = win.getFutureFlipTime(clock="now")
instructClock.reset(-_timeToFirstFrame)  # t0 is time of first possible flip
frameN = -1

# -------Run Routine "instruct"-------
while continueRoutine:
    # get current time
    t = instructClock.getTime()
    tThisFlip = win.getFutureFlipTime(clock=instructClock)
    tThisFlipGlobal = win.getFutureFlipTime(clock=None)
    frameN = frameN + 1  # number of completed frames (so 0 is the first frame)
    # update/draw components on each frame
    
    # *instrText* updates
    if instrText.status == NOT_STARTED and tThisFlip >= 0-frameTolerance:
        # keep track of start time/frame for later
        instrText.frameNStart = frameN  # exact frame index
        instrText.tStart = t  # local t and not account for scr refresh
        instrText.tStartRefresh = tThisFlipGlobal  # on global time
        win.timeOnFlip(instrText, 'tStartRefresh')  # time at next scr refresh
        instrText.setAutoDraw(True)
    
    # *ready* updates
    waitOnFlip = False
    if ready.status == NOT_STARTED and tThisFlip >= 0-frameTolerance:
        # keep track of start time/frame for later
        ready.frameNStart = frameN  # exact frame index
        ready.tStart = t  # local t and not account for scr refresh
        ready.tStartRefresh = tThisFlipGlobal  # on global time
        win.timeOnFlip(ready, 'tStartRefresh')  # time at next scr refresh
        ready.status = STARTED
        # keyboard checking is just starting
        waitOnFlip = True
        win.callOnFlip(ready.clock.reset)  # t=0 on next screen flip
        win.callOnFlip(ready.clearEvents, eventType='keyboard')  # clear events on next screen flip
    if ready.status == STARTED and not waitOnFlip:
        theseKeys = ready.getKeys(keyList=None, waitRelease=False)
        _ready_allKeys.extend(theseKeys)
        if len(_ready_allKeys):
            ready.keys = _ready_allKeys[-1].name  # just the last key pressed
            ready.rt = _ready_allKeys[-1].rt
            # a response ends the routine
            continueRoutine = False
    
    # check for quit (typically the Esc key)
    if endExpNow or defaultKeyboard.getKeys(keyList=["escape"]):
        core.quit()
    
    # check if all components have finished
    if not continueRoutine:  # a component has requested a forced-end of Routine
        break
    continueRoutine = False  # will revert to True if at least one component still running
    for thisComponent in instructComponents:
        if hasattr(thisComponent, "status") and thisComponent.status != FINISHED:
            continueRoutine = True
            break  # at least one component has not yet finished
    
    # refresh the screen
    if continueRoutine:  # don't flip if this routine is over or we'll get a blank screen
        win.flip()

# -------Ending Routine "instruct"-------
for thisComponent in instructComponents:
    if hasattr(thisComponent, "setAutoDraw"):
        thisComponent.setAutoDraw(False)
thisExp.addData('instrText.started', instrText.tStartRefresh)
thisExp.addData('instrText.stopped', instrText.tStopRefresh)
# the Routine "instruct" was not non-slip safe, so reset the non-slip timer
routineTimer.reset()

# set up handler to look after randomisation of conditions etc
trials = data.TrialHandler(nReps=1, method='random', 
    extraInfo=expInfo, originPath=-1,
    trialList=data.importConditions('practice_condition.csv'),
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
    
    # ------Prepare to start Routine "practice"-------
    continueRoutine = True
    # update component parameters for each repeat
    sound_1.setSound(stimuli, hamming=False)
    sound_1.setVolume(1, log=False)
    resp.keys = []
    resp.rt = []
    _resp_allKeys = []
    # keep track of which components have finished
    practiceComponents = [cross_tr, sound_1, resp, eefree_p, offree_practice]
    for thisComponent in practiceComponents:
        thisComponent.tStart = None
        thisComponent.tStop = None
        thisComponent.tStartRefresh = None
        thisComponent.tStopRefresh = None
        if hasattr(thisComponent, 'status'):
            thisComponent.status = NOT_STARTED
    # reset timers
    t = 0
    _timeToFirstFrame = win.getFutureFlipTime(clock="now")
    practiceClock.reset(-_timeToFirstFrame)  # t0 is time of first possible flip
    frameN = -1
    
    # -------Run Routine "practice"-------
    while continueRoutine:
        # get current time
        t = practiceClock.getTime()
        tThisFlip = win.getFutureFlipTime(clock=practiceClock)
        tThisFlipGlobal = win.getFutureFlipTime(clock=None)
        frameN = frameN + 1  # number of completed frames (so 0 is the first frame)
        # update/draw components on each frame
        
        # *cross_tr* updates
        if cross_tr.status == NOT_STARTED and tThisFlip >= 0.0-frameTolerance:
            # keep track of start time/frame for later
            cross_tr.frameNStart = frameN  # exact frame index
            cross_tr.tStart = t  # local t and not account for scr refresh
            cross_tr.tStartRefresh = tThisFlipGlobal  # on global time
            win.timeOnFlip(cross_tr, 'tStartRefresh')  # time at next scr refresh
            cross_tr.setAutoDraw(True)
        if cross_tr.status == STARTED:
            # is it time to stop? (based on global clock, using actual start)
            if tThisFlipGlobal > cross_tr.tStartRefresh + .4-frameTolerance:
                # keep track of stop time/frame for later
                cross_tr.tStop = t  # not accounting for scr refresh
                cross_tr.frameNStop = frameN  # exact frame index
                win.timeOnFlip(cross_tr, 'tStopRefresh')  # time at next scr refresh
                cross_tr.setAutoDraw(False)
        # start/stop sound_1
        if sound_1.status == NOT_STARTED and tThisFlip >= .5-frameTolerance:
            # keep track of start time/frame for later
            sound_1.frameNStart = frameN  # exact frame index
            sound_1.tStart = t  # local t and not account for scr refresh
            sound_1.tStartRefresh = tThisFlipGlobal  # on global time
            sound_1.play(when=win)  # sync with win flip
        
        # *resp* updates
        waitOnFlip = False
        if resp.status == NOT_STARTED and tThisFlip >= 0.5-frameTolerance:
            # keep track of start time/frame for later
            resp.frameNStart = frameN  # exact frame index
            resp.tStart = t  # local t and not account for scr refresh
            resp.tStartRefresh = tThisFlipGlobal  # on global time
            win.timeOnFlip(resp, 'tStartRefresh')  # time at next scr refresh
            resp.status = STARTED
            # keyboard checking is just starting
            waitOnFlip = True
            win.callOnFlip(resp.clock.reset)  # t=0 on next screen flip
            win.callOnFlip(resp.clearEvents, eventType='keyboard')  # clear events on next screen flip
        if resp.status == STARTED and not waitOnFlip:
            theseKeys = resp.getKeys(keyList=['left', 'right'], waitRelease=False)
            _resp_allKeys.extend(theseKeys)
            if len(_resp_allKeys):
                resp.keys = _resp_allKeys[-1].name  # just the last key pressed
                resp.rt = _resp_allKeys[-1].rt
                # a response ends the routine
                continueRoutine = False
        
        # *eefree_p* updates
        if eefree_p.status == NOT_STARTED and tThisFlip >= .5-frameTolerance:
            # keep track of start time/frame for later
            eefree_p.frameNStart = frameN  # exact frame index
            eefree_p.tStart = t  # local t and not account for scr refresh
            eefree_p.tStartRefresh = tThisFlipGlobal  # on global time
            win.timeOnFlip(eefree_p, 'tStartRefresh')  # time at next scr refresh
            eefree_p.setAutoDraw(True)
        
        # *offree_practice* updates
        if offree_practice.status == NOT_STARTED and tThisFlip >= .5-frameTolerance:
            # keep track of start time/frame for later
            offree_practice.frameNStart = frameN  # exact frame index
            offree_practice.tStart = t  # local t and not account for scr refresh
            offree_practice.tStartRefresh = tThisFlipGlobal  # on global time
            win.timeOnFlip(offree_practice, 'tStartRefresh')  # time at next scr refresh
            offree_practice.setAutoDraw(True)
        
        # check for quit (typically the Esc key)
        if endExpNow or defaultKeyboard.getKeys(keyList=["escape"]):
            core.quit()
        
        # check if all components have finished
        if not continueRoutine:  # a component has requested a forced-end of Routine
            break
        continueRoutine = False  # will revert to True if at least one component still running
        for thisComponent in practiceComponents:
            if hasattr(thisComponent, "status") and thisComponent.status != FINISHED:
                continueRoutine = True
                break  # at least one component has not yet finished
        
        # refresh the screen
        if continueRoutine:  # don't flip if this routine is over or we'll get a blank screen
            win.flip()
    
    # -------Ending Routine "practice"-------
    for thisComponent in practiceComponents:
        if hasattr(thisComponent, "setAutoDraw"):
            thisComponent.setAutoDraw(False)
    trials.addData('cross_tr.started', cross_tr.tStartRefresh)
    trials.addData('cross_tr.stopped', cross_tr.tStopRefresh)
    sound_1.stop()  # ensure sound has stopped at end of routine
    trials.addData('sound_1.started', sound_1.tStartRefresh)
    trials.addData('sound_1.stopped', sound_1.tStopRefresh)
    # check responses
    if resp.keys in ['', [], None]:  # No response was made
        resp.keys = None
    trials.addData('resp.keys',resp.keys)
    if resp.keys != None:  # we had a response
        trials.addData('resp.rt', resp.rt)
    trials.addData('resp.started', resp.tStartRefresh)
    trials.addData('resp.stopped', resp.tStopRefresh)
    trials.addData('eefree_p.started', eefree_p.tStartRefresh)
    trials.addData('eefree_p.stopped', eefree_p.tStopRefresh)
    trials.addData('offree_practice.started', offree_practice.tStartRefresh)
    trials.addData('offree_practice.stopped', offree_practice.tStopRefresh)
    # the Routine "practice" was not non-slip safe, so reset the non-slip timer
    routineTimer.reset()
    thisExp.nextEntry()
    
# completed 1 repeats of 'trials'

# get names of stimulus parameters
if trials.trialList in ([], [None], None):
    params = []
else:
    params = trials.trialList[0].keys()
# save data for this loop
trials.saveAsExcel(filename + '.xlsx', sheetName='trials',
    stimOut=params,
    dataOut=['n','all_mean','all_std', 'all_raw'])

# ------Prepare to start Routine "got_it"-------
continueRoutine = True
# update component parameters for each repeat
gotResponse.keys = []
gotResponse.rt = []
_gotResponse_allKeys = []
# keep track of which components have finished
got_itComponents = [gotIT, gotResponse]
for thisComponent in got_itComponents:
    thisComponent.tStart = None
    thisComponent.tStop = None
    thisComponent.tStartRefresh = None
    thisComponent.tStopRefresh = None
    if hasattr(thisComponent, 'status'):
        thisComponent.status = NOT_STARTED
# reset timers
t = 0
_timeToFirstFrame = win.getFutureFlipTime(clock="now")
got_itClock.reset(-_timeToFirstFrame)  # t0 is time of first possible flip
frameN = -1

# -------Run Routine "got_it"-------
while continueRoutine:
    # get current time
    t = got_itClock.getTime()
    tThisFlip = win.getFutureFlipTime(clock=got_itClock)
    tThisFlipGlobal = win.getFutureFlipTime(clock=None)
    frameN = frameN + 1  # number of completed frames (so 0 is the first frame)
    # update/draw components on each frame
    
    # *gotIT* updates
    if gotIT.status == NOT_STARTED and tThisFlip >= .75-frameTolerance:
        # keep track of start time/frame for later
        gotIT.frameNStart = frameN  # exact frame index
        gotIT.tStart = t  # local t and not account for scr refresh
        gotIT.tStartRefresh = tThisFlipGlobal  # on global time
        win.timeOnFlip(gotIT, 'tStartRefresh')  # time at next scr refresh
        gotIT.setAutoDraw(True)
    if gotIT.status == STARTED:
        # is it time to stop? (based on global clock, using actual start)
        if tThisFlipGlobal > gotIT.tStartRefresh + 1.0-frameTolerance:
            # keep track of stop time/frame for later
            gotIT.tStop = t  # not accounting for scr refresh
            gotIT.frameNStop = frameN  # exact frame index
            win.timeOnFlip(gotIT, 'tStopRefresh')  # time at next scr refresh
            gotIT.setAutoDraw(False)
    
    # *gotResponse* updates
    waitOnFlip = False
    if gotResponse.status == NOT_STARTED and tThisFlip >= 1.0-frameTolerance:
        # keep track of start time/frame for later
        gotResponse.frameNStart = frameN  # exact frame index
        gotResponse.tStart = t  # local t and not account for scr refresh
        gotResponse.tStartRefresh = tThisFlipGlobal  # on global time
        win.timeOnFlip(gotResponse, 'tStartRefresh')  # time at next scr refresh
        gotResponse.status = STARTED
        # keyboard checking is just starting
        waitOnFlip = True
        win.callOnFlip(gotResponse.clock.reset)  # t=0 on next screen flip
        win.callOnFlip(gotResponse.clearEvents, eventType='keyboard')  # clear events on next screen flip
    if gotResponse.status == STARTED and not waitOnFlip:
        theseKeys = gotResponse.getKeys(keyList=['space'], waitRelease=False)
        _gotResponse_allKeys.extend(theseKeys)
        if len(_gotResponse_allKeys):
            gotResponse.keys = _gotResponse_allKeys[-1].name  # just the last key pressed
            gotResponse.rt = _gotResponse_allKeys[-1].rt
            # a response ends the routine
            continueRoutine = False
    
    # check for quit (typically the Esc key)
    if endExpNow or defaultKeyboard.getKeys(keyList=["escape"]):
        core.quit()
    
    # check if all components have finished
    if not continueRoutine:  # a component has requested a forced-end of Routine
        break
    continueRoutine = False  # will revert to True if at least one component still running
    for thisComponent in got_itComponents:
        if hasattr(thisComponent, "status") and thisComponent.status != FINISHED:
            continueRoutine = True
            break  # at least one component has not yet finished
    
    # refresh the screen
    if continueRoutine:  # don't flip if this routine is over or we'll get a blank screen
        win.flip()

# -------Ending Routine "got_it"-------
for thisComponent in got_itComponents:
    if hasattr(thisComponent, "setAutoDraw"):
        thisComponent.setAutoDraw(False)
thisExp.addData('gotIT.started', gotIT.tStartRefresh)
thisExp.addData('gotIT.stopped', gotIT.tStopRefresh)
# check responses
if gotResponse.keys in ['', [], None]:  # No response was made
    gotResponse.keys = None
thisExp.addData('gotResponse.keys',gotResponse.keys)
if gotResponse.keys != None:  # we had a response
    thisExp.addData('gotResponse.rt', gotResponse.rt)
thisExp.addData('gotResponse.started', gotResponse.tStartRefresh)
thisExp.addData('gotResponse.stopped', gotResponse.tStopRefresh)
thisExp.nextEntry()
# the Routine "got_it" was not non-slip safe, so reset the non-slip timer
routineTimer.reset()

# set up handler to look after randomisation of conditions etc
trials_2 = data.TrialHandler(nReps=5, method='random', 
    extraInfo=expInfo, originPath=-1,
    trialList=data.importConditions('condition.csv'),
    seed=None, name='trials_2')
thisExp.addLoop(trials_2)  # add the loop to the experiment
thisTrial_2 = trials_2.trialList[0]  # so we can initialise stimuli with some values
# abbreviate parameter names if possible (e.g. rgb = thisTrial_2.rgb)
if thisTrial_2 != None:
    for paramName in thisTrial_2:
        exec('{} = thisTrial_2[paramName]'.format(paramName))

for thisTrial_2 in trials_2:
    currentLoop = trials_2
    # abbreviate parameter names if possible (e.g. rgb = thisTrial_2.rgb)
    if thisTrial_2 != None:
        for paramName in thisTrial_2:
            exec('{} = thisTrial_2[paramName]'.format(paramName))
    
    # ------Prepare to start Routine "i_u"-------
    continueRoutine = True
    # update component parameters for each repeat
    sound_2.setSound(stimuli, hamming=False)
    sound_2.setVolume(1, log=False)
    resp_2.keys = []
    resp_2.rt = []
    _resp_2_allKeys = []
    # keep track of which components have finished
    i_uComponents = [cross_tr_2, sound_2, resp_2, eefree_p_2, offree_practice_2]
    for thisComponent in i_uComponents:
        thisComponent.tStart = None
        thisComponent.tStop = None
        thisComponent.tStartRefresh = None
        thisComponent.tStopRefresh = None
        if hasattr(thisComponent, 'status'):
            thisComponent.status = NOT_STARTED
    # reset timers
    t = 0
    _timeToFirstFrame = win.getFutureFlipTime(clock="now")
    i_uClock.reset(-_timeToFirstFrame)  # t0 is time of first possible flip
    frameN = -1
    
    # -------Run Routine "i_u"-------
    while continueRoutine:
        # get current time
        t = i_uClock.getTime()
        tThisFlip = win.getFutureFlipTime(clock=i_uClock)
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
        
        # *eefree_p_2* updates
        if eefree_p_2.status == NOT_STARTED and tThisFlip >= .5-frameTolerance:
            # keep track of start time/frame for later
            eefree_p_2.frameNStart = frameN  # exact frame index
            eefree_p_2.tStart = t  # local t and not account for scr refresh
            eefree_p_2.tStartRefresh = tThisFlipGlobal  # on global time
            win.timeOnFlip(eefree_p_2, 'tStartRefresh')  # time at next scr refresh
            eefree_p_2.setAutoDraw(True)
        
        # *offree_practice_2* updates
        if offree_practice_2.status == NOT_STARTED and tThisFlip >= .5-frameTolerance:
            # keep track of start time/frame for later
            offree_practice_2.frameNStart = frameN  # exact frame index
            offree_practice_2.tStart = t  # local t and not account for scr refresh
            offree_practice_2.tStartRefresh = tThisFlipGlobal  # on global time
            win.timeOnFlip(offree_practice_2, 'tStartRefresh')  # time at next scr refresh
            offree_practice_2.setAutoDraw(True)
        
        # check for quit (typically the Esc key)
        if endExpNow or defaultKeyboard.getKeys(keyList=["escape"]):
            core.quit()
        
        # check if all components have finished
        if not continueRoutine:  # a component has requested a forced-end of Routine
            break
        continueRoutine = False  # will revert to True if at least one component still running
        for thisComponent in i_uComponents:
            if hasattr(thisComponent, "status") and thisComponent.status != FINISHED:
                continueRoutine = True
                break  # at least one component has not yet finished
        
        # refresh the screen
        if continueRoutine:  # don't flip if this routine is over or we'll get a blank screen
            win.flip()
    
    # -------Ending Routine "i_u"-------
    for thisComponent in i_uComponents:
        if hasattr(thisComponent, "setAutoDraw"):
            thisComponent.setAutoDraw(False)
    trials_2.addData('cross_tr_2.started', cross_tr_2.tStartRefresh)
    trials_2.addData('cross_tr_2.stopped', cross_tr_2.tStopRefresh)
    sound_2.stop()  # ensure sound has stopped at end of routine
    trials_2.addData('sound_2.started', sound_2.tStartRefresh)
    trials_2.addData('sound_2.stopped', sound_2.tStopRefresh)
    # check responses
    if resp_2.keys in ['', [], None]:  # No response was made
        resp_2.keys = None
    trials_2.addData('resp_2.keys',resp_2.keys)
    if resp_2.keys != None:  # we had a response
        trials_2.addData('resp_2.rt', resp_2.rt)
    trials_2.addData('resp_2.started', resp_2.tStartRefresh)
    trials_2.addData('resp_2.stopped', resp_2.tStopRefresh)
    trials_2.addData('eefree_p_2.started', eefree_p_2.tStartRefresh)
    trials_2.addData('eefree_p_2.stopped', eefree_p_2.tStopRefresh)
    trials_2.addData('offree_practice_2.started', offree_practice_2.tStartRefresh)
    trials_2.addData('offree_practice_2.stopped', offree_practice_2.tStopRefresh)
    # the Routine "i_u" was not non-slip safe, so reset the non-slip timer
    routineTimer.reset()
    thisExp.nextEntry()
    
# completed 5 repeats of 'trials_2'

# get names of stimulus parameters
if trials_2.trialList in ([], [None], None):
    params = []
else:
    params = trials_2.trialList[0].keys()
# save data for this loop
trials_2.saveAsExcel(filename + '.xlsx', sheetName='trials_2',
    stimOut=params,
    dataOut=['n','all_mean','all_std', 'all_raw'])

# ------Prepare to start Routine "instruct_2"-------
continueRoutine = True
# update component parameters for each repeat
ready_2.keys = []
ready_2.rt = []
_ready_2_allKeys = []
# keep track of which components have finished
instruct_2Components = [instrText_2, ready_2]
for thisComponent in instruct_2Components:
    thisComponent.tStart = None
    thisComponent.tStop = None
    thisComponent.tStartRefresh = None
    thisComponent.tStopRefresh = None
    if hasattr(thisComponent, 'status'):
        thisComponent.status = NOT_STARTED
# reset timers
t = 0
_timeToFirstFrame = win.getFutureFlipTime(clock="now")
instruct_2Clock.reset(-_timeToFirstFrame)  # t0 is time of first possible flip
frameN = -1

# -------Run Routine "instruct_2"-------
while continueRoutine:
    # get current time
    t = instruct_2Clock.getTime()
    tThisFlip = win.getFutureFlipTime(clock=instruct_2Clock)
    tThisFlipGlobal = win.getFutureFlipTime(clock=None)
    frameN = frameN + 1  # number of completed frames (so 0 is the first frame)
    # update/draw components on each frame
    
    # *instrText_2* updates
    if instrText_2.status == NOT_STARTED and tThisFlip >= 0-frameTolerance:
        # keep track of start time/frame for later
        instrText_2.frameNStart = frameN  # exact frame index
        instrText_2.tStart = t  # local t and not account for scr refresh
        instrText_2.tStartRefresh = tThisFlipGlobal  # on global time
        win.timeOnFlip(instrText_2, 'tStartRefresh')  # time at next scr refresh
        instrText_2.setAutoDraw(True)
    
    # *ready_2* updates
    waitOnFlip = False
    if ready_2.status == NOT_STARTED and tThisFlip >= 0-frameTolerance:
        # keep track of start time/frame for later
        ready_2.frameNStart = frameN  # exact frame index
        ready_2.tStart = t  # local t and not account for scr refresh
        ready_2.tStartRefresh = tThisFlipGlobal  # on global time
        win.timeOnFlip(ready_2, 'tStartRefresh')  # time at next scr refresh
        ready_2.status = STARTED
        # keyboard checking is just starting
        waitOnFlip = True
        win.callOnFlip(ready_2.clock.reset)  # t=0 on next screen flip
        win.callOnFlip(ready_2.clearEvents, eventType='keyboard')  # clear events on next screen flip
    if ready_2.status == STARTED and not waitOnFlip:
        theseKeys = ready_2.getKeys(keyList=None, waitRelease=False)
        _ready_2_allKeys.extend(theseKeys)
        if len(_ready_2_allKeys):
            ready_2.keys = _ready_2_allKeys[-1].name  # just the last key pressed
            ready_2.rt = _ready_2_allKeys[-1].rt
            # a response ends the routine
            continueRoutine = False
    
    # check for quit (typically the Esc key)
    if endExpNow or defaultKeyboard.getKeys(keyList=["escape"]):
        core.quit()
    
    # check if all components have finished
    if not continueRoutine:  # a component has requested a forced-end of Routine
        break
    continueRoutine = False  # will revert to True if at least one component still running
    for thisComponent in instruct_2Components:
        if hasattr(thisComponent, "status") and thisComponent.status != FINISHED:
            continueRoutine = True
            break  # at least one component has not yet finished
    
    # refresh the screen
    if continueRoutine:  # don't flip if this routine is over or we'll get a blank screen
        win.flip()

# -------Ending Routine "instruct_2"-------
for thisComponent in instruct_2Components:
    if hasattr(thisComponent, "setAutoDraw"):
        thisComponent.setAutoDraw(False)
thisExp.addData('instrText_2.started', instrText_2.tStartRefresh)
thisExp.addData('instrText_2.stopped', instrText_2.tStopRefresh)
# the Routine "instruct_2" was not non-slip safe, so reset the non-slip timer
routineTimer.reset()

# set up handler to look after randomisation of conditions etc
trials_3 = data.TrialHandler(nReps=5, method='random', 
    extraInfo=expInfo, originPath=-1,
    trialList=data.importConditions('cond_2.xlsx'),
    seed=None, name='trials_3')
thisExp.addLoop(trials_3)  # add the loop to the experiment
thisTrial_3 = trials_3.trialList[0]  # so we can initialise stimuli with some values
# abbreviate parameter names if possible (e.g. rgb = thisTrial_3.rgb)
if thisTrial_3 != None:
    for paramName in thisTrial_3:
        exec('{} = thisTrial_3[paramName]'.format(paramName))

for thisTrial_3 in trials_3:
    currentLoop = trials_3
    # abbreviate parameter names if possible (e.g. rgb = thisTrial_3.rgb)
    if thisTrial_3 != None:
        for paramName in thisTrial_3:
            exec('{} = thisTrial_3[paramName]'.format(paramName))
    
    # ------Prepare to start Routine "ba_pa"-------
    continueRoutine = True
    # update component parameters for each repeat
    sound_3.setSound(stimuli, hamming=False)
    sound_3.setVolume(1, log=False)
    resp_3.keys = []
    resp_3.rt = []
    _resp_3_allKeys = []
    # keep track of which components have finished
    ba_paComponents = [cross_tr_3, sound_3, resp_3, pafri, bafri]
    for thisComponent in ba_paComponents:
        thisComponent.tStart = None
        thisComponent.tStop = None
        thisComponent.tStartRefresh = None
        thisComponent.tStopRefresh = None
        if hasattr(thisComponent, 'status'):
            thisComponent.status = NOT_STARTED
    # reset timers
    t = 0
    _timeToFirstFrame = win.getFutureFlipTime(clock="now")
    ba_paClock.reset(-_timeToFirstFrame)  # t0 is time of first possible flip
    frameN = -1
    
    # -------Run Routine "ba_pa"-------
    while continueRoutine:
        # get current time
        t = ba_paClock.getTime()
        tThisFlip = win.getFutureFlipTime(clock=ba_paClock)
        tThisFlipGlobal = win.getFutureFlipTime(clock=None)
        frameN = frameN + 1  # number of completed frames (so 0 is the first frame)
        # update/draw components on each frame
        
        # *cross_tr_3* updates
        if cross_tr_3.status == NOT_STARTED and tThisFlip >= 0.0-frameTolerance:
            # keep track of start time/frame for later
            cross_tr_3.frameNStart = frameN  # exact frame index
            cross_tr_3.tStart = t  # local t and not account for scr refresh
            cross_tr_3.tStartRefresh = tThisFlipGlobal  # on global time
            win.timeOnFlip(cross_tr_3, 'tStartRefresh')  # time at next scr refresh
            cross_tr_3.setAutoDraw(True)
        if cross_tr_3.status == STARTED:
            # is it time to stop? (based on global clock, using actual start)
            if tThisFlipGlobal > cross_tr_3.tStartRefresh + .4-frameTolerance:
                # keep track of stop time/frame for later
                cross_tr_3.tStop = t  # not accounting for scr refresh
                cross_tr_3.frameNStop = frameN  # exact frame index
                win.timeOnFlip(cross_tr_3, 'tStopRefresh')  # time at next scr refresh
                cross_tr_3.setAutoDraw(False)
        # start/stop sound_3
        if sound_3.status == NOT_STARTED and tThisFlip >= .5-frameTolerance:
            # keep track of start time/frame for later
            sound_3.frameNStart = frameN  # exact frame index
            sound_3.tStart = t  # local t and not account for scr refresh
            sound_3.tStartRefresh = tThisFlipGlobal  # on global time
            sound_3.play(when=win)  # sync with win flip
        
        # *resp_3* updates
        waitOnFlip = False
        if resp_3.status == NOT_STARTED and tThisFlip >= 0.5-frameTolerance:
            # keep track of start time/frame for later
            resp_3.frameNStart = frameN  # exact frame index
            resp_3.tStart = t  # local t and not account for scr refresh
            resp_3.tStartRefresh = tThisFlipGlobal  # on global time
            win.timeOnFlip(resp_3, 'tStartRefresh')  # time at next scr refresh
            resp_3.status = STARTED
            # keyboard checking is just starting
            waitOnFlip = True
            win.callOnFlip(resp_3.clock.reset)  # t=0 on next screen flip
            win.callOnFlip(resp_3.clearEvents, eventType='keyboard')  # clear events on next screen flip
        if resp_3.status == STARTED and not waitOnFlip:
            theseKeys = resp_3.getKeys(keyList=['left', 'right'], waitRelease=False)
            _resp_3_allKeys.extend(theseKeys)
            if len(_resp_3_allKeys):
                resp_3.keys = _resp_3_allKeys[-1].name  # just the last key pressed
                resp_3.rt = _resp_3_allKeys[-1].rt
                # a response ends the routine
                continueRoutine = False
        
        # *pafri* updates
        if pafri.status == NOT_STARTED and tThisFlip >= .5-frameTolerance:
            # keep track of start time/frame for later
            pafri.frameNStart = frameN  # exact frame index
            pafri.tStart = t  # local t and not account for scr refresh
            pafri.tStartRefresh = tThisFlipGlobal  # on global time
            win.timeOnFlip(pafri, 'tStartRefresh')  # time at next scr refresh
            pafri.setAutoDraw(True)
        
        # *bafri* updates
        if bafri.status == NOT_STARTED and tThisFlip >= .5-frameTolerance:
            # keep track of start time/frame for later
            bafri.frameNStart = frameN  # exact frame index
            bafri.tStart = t  # local t and not account for scr refresh
            bafri.tStartRefresh = tThisFlipGlobal  # on global time
            win.timeOnFlip(bafri, 'tStartRefresh')  # time at next scr refresh
            bafri.setAutoDraw(True)
        
        # check for quit (typically the Esc key)
        if endExpNow or defaultKeyboard.getKeys(keyList=["escape"]):
            core.quit()
        
        # check if all components have finished
        if not continueRoutine:  # a component has requested a forced-end of Routine
            break
        continueRoutine = False  # will revert to True if at least one component still running
        for thisComponent in ba_paComponents:
            if hasattr(thisComponent, "status") and thisComponent.status != FINISHED:
                continueRoutine = True
                break  # at least one component has not yet finished
        
        # refresh the screen
        if continueRoutine:  # don't flip if this routine is over or we'll get a blank screen
            win.flip()
    
    # -------Ending Routine "ba_pa"-------
    for thisComponent in ba_paComponents:
        if hasattr(thisComponent, "setAutoDraw"):
            thisComponent.setAutoDraw(False)
    trials_3.addData('cross_tr_3.started', cross_tr_3.tStartRefresh)
    trials_3.addData('cross_tr_3.stopped', cross_tr_3.tStopRefresh)
    sound_3.stop()  # ensure sound has stopped at end of routine
    trials_3.addData('sound_3.started', sound_3.tStartRefresh)
    trials_3.addData('sound_3.stopped', sound_3.tStopRefresh)
    # check responses
    if resp_3.keys in ['', [], None]:  # No response was made
        resp_3.keys = None
    trials_3.addData('resp_3.keys',resp_3.keys)
    if resp_3.keys != None:  # we had a response
        trials_3.addData('resp_3.rt', resp_3.rt)
    trials_3.addData('resp_3.started', resp_3.tStartRefresh)
    trials_3.addData('resp_3.stopped', resp_3.tStopRefresh)
    trials_3.addData('pafri.started', pafri.tStartRefresh)
    trials_3.addData('pafri.stopped', pafri.tStopRefresh)
    trials_3.addData('bafri.started', bafri.tStartRefresh)
    trials_3.addData('bafri.stopped', bafri.tStopRefresh)
    # the Routine "ba_pa" was not non-slip safe, so reset the non-slip timer
    routineTimer.reset()
    thisExp.nextEntry()
    
# completed 5 repeats of 'trials_3'

# get names of stimulus parameters
if trials_3.trialList in ([], [None], None):
    params = []
else:
    params = trials_3.trialList[0].keys()
# save data for this loop
trials_3.saveAsExcel(filename + '.xlsx', sheetName='trials_3',
    stimOut=params,
    dataOut=['n','all_mean','all_std', 'all_raw'])

# ------Prepare to start Routine "thanks"-------
continueRoutine = True
routineTimer.add(2.000000)
# update component parameters for each repeat
# keep track of which components have finished
thanksComponents = [thanksText]
for thisComponent in thanksComponents:
    thisComponent.tStart = None
    thisComponent.tStop = None
    thisComponent.tStartRefresh = None
    thisComponent.tStopRefresh = None
    if hasattr(thisComponent, 'status'):
        thisComponent.status = NOT_STARTED
# reset timers
t = 0
_timeToFirstFrame = win.getFutureFlipTime(clock="now")
thanksClock.reset(-_timeToFirstFrame)  # t0 is time of first possible flip
frameN = -1

# -------Run Routine "thanks"-------
while continueRoutine and routineTimer.getTime() > 0:
    # get current time
    t = thanksClock.getTime()
    tThisFlip = win.getFutureFlipTime(clock=thanksClock)
    tThisFlipGlobal = win.getFutureFlipTime(clock=None)
    frameN = frameN + 1  # number of completed frames (so 0 is the first frame)
    # update/draw components on each frame
    
    # *thanksText* updates
    if thanksText.status == NOT_STARTED and tThisFlip >= 0.0-frameTolerance:
        # keep track of start time/frame for later
        thanksText.frameNStart = frameN  # exact frame index
        thanksText.tStart = t  # local t and not account for scr refresh
        thanksText.tStartRefresh = tThisFlipGlobal  # on global time
        win.timeOnFlip(thanksText, 'tStartRefresh')  # time at next scr refresh
        thanksText.setAutoDraw(True)
    if thanksText.status == STARTED:
        # is it time to stop? (based on global clock, using actual start)
        if tThisFlipGlobal > thanksText.tStartRefresh + 2.0-frameTolerance:
            # keep track of stop time/frame for later
            thanksText.tStop = t  # not accounting for scr refresh
            thanksText.frameNStop = frameN  # exact frame index
            win.timeOnFlip(thanksText, 'tStopRefresh')  # time at next scr refresh
            thanksText.setAutoDraw(False)
    
    # check for quit (typically the Esc key)
    if endExpNow or defaultKeyboard.getKeys(keyList=["escape"]):
        core.quit()
    
    # check if all components have finished
    if not continueRoutine:  # a component has requested a forced-end of Routine
        break
    continueRoutine = False  # will revert to True if at least one component still running
    for thisComponent in thanksComponents:
        if hasattr(thisComponent, "status") and thisComponent.status != FINISHED:
            continueRoutine = True
            break  # at least one component has not yet finished
    
    # refresh the screen
    if continueRoutine:  # don't flip if this routine is over or we'll get a blank screen
        win.flip()

# -------Ending Routine "thanks"-------
for thisComponent in thanksComponents:
    if hasattr(thisComponent, "setAutoDraw"):
        thisComponent.setAutoDraw(False)
thisExp.addData('thanksText.started', thanksText.tStartRefresh)
thisExp.addData('thanksText.stopped', thanksText.tStopRefresh)

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
