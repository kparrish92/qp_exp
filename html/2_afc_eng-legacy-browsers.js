/****************** 
 * 2_Afc_Eng Test *
 ******************/

// init psychoJS:
const psychoJS = new PsychoJS({
  debug: true
});

// open window:
psychoJS.openWindow({
  fullscr: true,
  color: new util.Color('black'),
  units: 'norm',
  waitBlanking: true
});

// store info about the experiment session:
let expName = '2_afc_eng';  // from the Builder filename that created this script
let expInfo = {'session': '01', 'participant': ''};

// schedule the experiment:
psychoJS.schedule(psychoJS.gui.DlgFromDict({
  dictionary: expInfo,
  title: expName
}));

const flowScheduler = new Scheduler(psychoJS);
const dialogCancelScheduler = new Scheduler(psychoJS);
psychoJS.scheduleCondition(function() { return (psychoJS.gui.dialogComponent.button === 'OK'); }, flowScheduler, dialogCancelScheduler);

// flowScheduler gets run if the participants presses OK
flowScheduler.add(updateInfo); // add timeStamp
flowScheduler.add(experimentInit);
flowScheduler.add(instructRoutineBegin());
flowScheduler.add(instructRoutineEachFrame());
flowScheduler.add(instructRoutineEnd());
const trialsLoopScheduler = new Scheduler(psychoJS);
flowScheduler.add(trialsLoopBegin, trialsLoopScheduler);
flowScheduler.add(trialsLoopScheduler);
flowScheduler.add(trialsLoopEnd);
flowScheduler.add(got_itRoutineBegin());
flowScheduler.add(got_itRoutineEachFrame());
flowScheduler.add(got_itRoutineEnd());
const trials_2LoopScheduler = new Scheduler(psychoJS);
flowScheduler.add(trials_2LoopBegin, trials_2LoopScheduler);
flowScheduler.add(trials_2LoopScheduler);
flowScheduler.add(trials_2LoopEnd);
flowScheduler.add(thanksRoutineBegin());
flowScheduler.add(thanksRoutineEachFrame());
flowScheduler.add(thanksRoutineEnd());
flowScheduler.add(quitPsychoJS, '', true);

// quit if user presses Cancel in dialog box:
dialogCancelScheduler.add(quitPsychoJS, '', false);

psychoJS.start({
  expName: expName,
  expInfo: expInfo,
  });


var frameDur;
function updateInfo() {
  expInfo['date'] = util.MonotonicClock.getDateStr();  // add a simple timestamp
  expInfo['expName'] = expName;
  expInfo['psychopyVersion'] = '2020.2.3';
  expInfo['OS'] = window.navigator.platform;

  // store frame rate of monitor if we can measure it successfully
  expInfo['frameRate'] = psychoJS.window.getActualFrameRate();
  if (typeof expInfo['frameRate'] !== 'undefined')
    frameDur = 1.0 / Math.round(expInfo['frameRate']);
  else
    frameDur = 1.0 / 60.0; // couldn't get a reliable measure so guess

  // add info from the URL:
  util.addInfoFromUrl(expInfo);
  
  return Scheduler.Event.NEXT;
}


var instructClock;
var instrText;
var ready;
var practiceClock;
var cross_tr;
var sound_1;
var resp;
var eefree_p;
var offree_practice;
var got_itClock;
var gotIT;
var gotResponse;
var practice_2Clock;
var cross_tr_2;
var sound_2;
var resp_2;
var eefree_p_2;
var offree_practice_2;
var thanksClock;
var thanksText;
var globalClock;
var routineTimer;
function experimentInit() {
  // Initialize components for Routine "instruct"
  instructClock = new util.Clock();
  instrText = new visual.TextStim({
    win: psychoJS.window,
    name: 'instrText',
    text: 'Practice Instructions - use the left and right mouse key to answer.  You will hear the beginning of a rare word in English. Use the left or right mouse key to decide which word is beginning to be said. ',
    font: 'Arial',
    units: undefined, 
    pos: [0, 0], height: 0.1,  wrapWidth: undefined, ori: 0,
    color: new util.Color([1, 1, 1]),  opacity: 1,
    depth: 0.0 
  });
  
  ready = new core.Keyboard({psychoJS: psychoJS, clock: new util.Clock(), waitForStart: true});
  
  // Initialize components for Routine "practice"
  practiceClock = new util.Clock();
  cross_tr = new visual.TextStim({
    win: psychoJS.window,
    name: 'cross_tr',
    text: '+',
    font: 'Arial',
    units: undefined, 
    pos: [0, 0], height: 0.1,  wrapWidth: undefined, ori: 0,
    color: new util.Color('red'),  opacity: 1,
    depth: 0.0 
  });
  
  sound_1 = new sound.Sound({
    win: psychoJS.window,
    value: 'A',
    secs: (- 1),
    });
  sound_1.setVolume(1);
  resp = new core.Keyboard({psychoJS: psychoJS, clock: new util.Clock(), waitForStart: true});
  
  eefree_p = new visual.TextStim({
    win: psychoJS.window,
    name: 'eefree_p',
    text: 'eefree',
    font: 'Arial',
    units: undefined, 
    pos: [(- 0.4), (- 0.2)], height: 0.1,  wrapWidth: undefined, ori: 0,
    color: new util.Color('white'),  opacity: 1,
    depth: -3.0 
  });
  
  offree_practice = new visual.TextStim({
    win: psychoJS.window,
    name: 'offree_practice',
    text: 'oofree\n',
    font: 'Arial',
    units: undefined, 
    pos: [0.4, (- 0.25)], height: 0.1,  wrapWidth: undefined, ori: 0,
    color: new util.Color('white'),  opacity: 1,
    depth: -4.0 
  });
  
  // Initialize components for Routine "got_it"
  got_itClock = new util.Clock();
  gotIT = new visual.TextStim({
    win: psychoJS.window,
    name: 'gotIT',
    text: 'Got it? If you have any questions please ask the experimenter now. If not, press the spacebar to begin the experiment. ',
    font: 'Arial',
    units: undefined, 
    pos: [0, 0], height: 0.08,  wrapWidth: undefined, ori: 0,
    color: new util.Color('white'),  opacity: 1,
    depth: 0.0 
  });
  
  gotResponse = new core.Keyboard({psychoJS: psychoJS, clock: new util.Clock(), waitForStart: true});
  
  // Initialize components for Routine "practice_2"
  practice_2Clock = new util.Clock();
  cross_tr_2 = new visual.TextStim({
    win: psychoJS.window,
    name: 'cross_tr_2',
    text: '+',
    font: 'Arial',
    units: undefined, 
    pos: [0, 0], height: 0.1,  wrapWidth: undefined, ori: 0,
    color: new util.Color('red'),  opacity: 1,
    depth: 0.0 
  });
  
  sound_2 = new sound.Sound({
    win: psychoJS.window,
    value: 'A',
    secs: (- 1),
    });
  sound_2.setVolume(1);
  resp_2 = new core.Keyboard({psychoJS: psychoJS, clock: new util.Clock(), waitForStart: true});
  
  eefree_p_2 = new visual.TextStim({
    win: psychoJS.window,
    name: 'eefree_p_2',
    text: 'eefree',
    font: 'Arial',
    units: undefined, 
    pos: [(- 0.4), (- 0.2)], height: 0.1,  wrapWidth: undefined, ori: 0,
    color: new util.Color('white'),  opacity: 1,
    depth: -3.0 
  });
  
  offree_practice_2 = new visual.TextStim({
    win: psychoJS.window,
    name: 'offree_practice_2',
    text: 'oofree\n',
    font: 'Arial',
    units: undefined, 
    pos: [0.4, (- 0.25)], height: 0.1,  wrapWidth: undefined, ori: 0,
    color: new util.Color('white'),  opacity: 1,
    depth: -4.0 
  });
  
  // Initialize components for Routine "thanks"
  thanksClock = new util.Clock();
  thanksText = new visual.TextStim({
    win: psychoJS.window,
    name: 'thanksText',
    text: 'This is the end of the experiment.\n\nThanks!',
    font: 'arial',
    units: undefined, 
    pos: [0, 0], height: 0.1,  wrapWidth: undefined, ori: 0,
    color: new util.Color([1, 1, 1]),  opacity: 1,
    depth: 0.0 
  });
  
  // Create some handy timers
  globalClock = new util.Clock();  // to track the time since experiment started
  routineTimer = new util.CountdownTimer();  // to track time remaining of each (non-slip) routine
  
  return Scheduler.Event.NEXT;
}


var t;
var frameN;
var _ready_allKeys;
var instructComponents;
function instructRoutineBegin(snapshot) {
  return function () {
    //------Prepare to start Routine 'instruct'-------
    t = 0;
    instructClock.reset(); // clock
    frameN = -1;
    // update component parameters for each repeat
    ready.keys = undefined;
    ready.rt = undefined;
    _ready_allKeys = [];
    // keep track of which components have finished
    instructComponents = [];
    instructComponents.push(instrText);
    instructComponents.push(ready);
    
    instructComponents.forEach( function(thisComponent) {
      if ('status' in thisComponent)
        thisComponent.status = PsychoJS.Status.NOT_STARTED;
       });
    
    return Scheduler.Event.NEXT;
  };
}


var continueRoutine;
function instructRoutineEachFrame(snapshot) {
  return function () {
    //------Loop for each frame of Routine 'instruct'-------
    let continueRoutine = true; // until we're told otherwise
    // get current time
    t = instructClock.getTime();
    frameN = frameN + 1;// number of completed frames (so 0 is the first frame)
    // update/draw components on each frame
    
    // *instrText* updates
    if (t >= 0 && instrText.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      instrText.tStart = t;  // (not accounting for frame time here)
      instrText.frameNStart = frameN;  // exact frame index
      
      instrText.setAutoDraw(true);
    }

    
    // *ready* updates
    if (t >= 0 && ready.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      ready.tStart = t;  // (not accounting for frame time here)
      ready.frameNStart = frameN;  // exact frame index
      
      // keyboard checking is just starting
      psychoJS.window.callOnFlip(function() { ready.clock.reset(); });  // t=0 on next screen flip
      psychoJS.window.callOnFlip(function() { ready.start(); }); // start on screen flip
      psychoJS.window.callOnFlip(function() { ready.clearEvents(); });
    }

    if (ready.status === PsychoJS.Status.STARTED) {
      let theseKeys = ready.getKeys({keyList: [], waitRelease: false});
      _ready_allKeys = _ready_allKeys.concat(theseKeys);
      if (_ready_allKeys.length > 0) {
        ready.keys = _ready_allKeys[_ready_allKeys.length - 1].name;  // just the last key pressed
        ready.rt = _ready_allKeys[_ready_allKeys.length - 1].rt;
        // a response ends the routine
        continueRoutine = false;
      }
    }
    
    // check for quit (typically the Esc key)
    if (psychoJS.experiment.experimentEnded || psychoJS.eventManager.getKeys({keyList:['escape']}).length > 0) {
      return quitPsychoJS('The [Escape] key was pressed. Goodbye!', false);
    }
    
    // check if the Routine should terminate
    if (!continueRoutine) {  // a component has requested a forced-end of Routine
      return Scheduler.Event.NEXT;
    }
    
    continueRoutine = false;  // reverts to True if at least one component still running
    instructComponents.forEach( function(thisComponent) {
      if ('status' in thisComponent && thisComponent.status !== PsychoJS.Status.FINISHED) {
        continueRoutine = true;
      }
    });
    
    // refresh the screen if continuing
    if (continueRoutine) {
      return Scheduler.Event.FLIP_REPEAT;
    } else {
      return Scheduler.Event.NEXT;
    }
  };
}


function instructRoutineEnd(snapshot) {
  return function () {
    //------Ending Routine 'instruct'-------
    instructComponents.forEach( function(thisComponent) {
      if (typeof thisComponent.setAutoDraw === 'function') {
        thisComponent.setAutoDraw(false);
      }
    });
    // the Routine "instruct" was not non-slip safe, so reset the non-slip timer
    routineTimer.reset();
    
    return Scheduler.Event.NEXT;
  };
}


var trials;
var currentLoop;
function trialsLoopBegin(trialsLoopScheduler) {
  // set up handler to look after randomisation of conditions etc
  trials = new TrialHandler({
    psychoJS: psychoJS,
    nReps: 1, method: TrialHandler.Method.RANDOM,
    extraInfo: expInfo, originPath: undefined,
    trialList: 'practice_condition.csv',
    seed: undefined, name: 'trials'
  });
  psychoJS.experiment.addLoop(trials); // add the loop to the experiment
  currentLoop = trials;  // we're now the current loop

  // Schedule all the trials in the trialList:
  trials.forEach(function() {
    const snapshot = trials.getSnapshot();

    trialsLoopScheduler.add(importConditions(snapshot));
    trialsLoopScheduler.add(practiceRoutineBegin(snapshot));
    trialsLoopScheduler.add(practiceRoutineEachFrame(snapshot));
    trialsLoopScheduler.add(practiceRoutineEnd(snapshot));
    trialsLoopScheduler.add(endLoopIteration(trialsLoopScheduler, snapshot));
  });

  return Scheduler.Event.NEXT;
}


function trialsLoopEnd() {
  psychoJS.experiment.removeLoop(trials);

  return Scheduler.Event.NEXT;
}


var trials_2;
function trials_2LoopBegin(trials_2LoopScheduler) {
  // set up handler to look after randomisation of conditions etc
  trials_2 = new TrialHandler({
    psychoJS: psychoJS,
    nReps: 5, method: TrialHandler.Method.RANDOM,
    extraInfo: expInfo, originPath: undefined,
    trialList: 'condition.csv',
    seed: undefined, name: 'trials_2'
  });
  psychoJS.experiment.addLoop(trials_2); // add the loop to the experiment
  currentLoop = trials_2;  // we're now the current loop

  // Schedule all the trials in the trialList:
  trials_2.forEach(function() {
    const snapshot = trials_2.getSnapshot();

    trials_2LoopScheduler.add(importConditions(snapshot));
    trials_2LoopScheduler.add(practice_2RoutineBegin(snapshot));
    trials_2LoopScheduler.add(practice_2RoutineEachFrame(snapshot));
    trials_2LoopScheduler.add(practice_2RoutineEnd(snapshot));
    trials_2LoopScheduler.add(endLoopIteration(trials_2LoopScheduler, snapshot));
  });

  return Scheduler.Event.NEXT;
}


function trials_2LoopEnd() {
  psychoJS.experiment.removeLoop(trials_2);

  return Scheduler.Event.NEXT;
}


var _resp_allKeys;
var practiceComponents;
function practiceRoutineBegin(snapshot) {
  return function () {
    //------Prepare to start Routine 'practice'-------
    t = 0;
    practiceClock.reset(); // clock
    frameN = -1;
    // update component parameters for each repeat
    sound_1 = new sound.Sound({
    win: psychoJS.window,
    value: stimuli,
    secs: -1,
    });
    sound_1.setVolume(1);
    resp.keys = undefined;
    resp.rt = undefined;
    _resp_allKeys = [];
    // keep track of which components have finished
    practiceComponents = [];
    practiceComponents.push(cross_tr);
    practiceComponents.push(sound_1);
    practiceComponents.push(resp);
    practiceComponents.push(eefree_p);
    practiceComponents.push(offree_practice);
    
    practiceComponents.forEach( function(thisComponent) {
      if ('status' in thisComponent)
        thisComponent.status = PsychoJS.Status.NOT_STARTED;
       });
    
    return Scheduler.Event.NEXT;
  };
}


var frameRemains;
function practiceRoutineEachFrame(snapshot) {
  return function () {
    //------Loop for each frame of Routine 'practice'-------
    let continueRoutine = true; // until we're told otherwise
    // get current time
    t = practiceClock.getTime();
    frameN = frameN + 1;// number of completed frames (so 0 is the first frame)
    // update/draw components on each frame
    
    // *cross_tr* updates
    if (t >= 0.0 && cross_tr.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      cross_tr.tStart = t;  // (not accounting for frame time here)
      cross_tr.frameNStart = frameN;  // exact frame index
      
      cross_tr.setAutoDraw(true);
    }

    frameRemains = 0.0 + 0.4 - psychoJS.window.monitorFramePeriod * 0.75;  // most of one frame period left
    if (cross_tr.status === PsychoJS.Status.STARTED && t >= frameRemains) {
      cross_tr.setAutoDraw(false);
    }
    // start/stop sound_1
    if (t >= 0.5 && sound_1.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      sound_1.tStart = t;  // (not accounting for frame time here)
      sound_1.frameNStart = frameN;  // exact frame index
      
      psychoJS.window.callOnFlip(function(){ sound_1.play(); });  // screen flip
      sound_1.status = PsychoJS.Status.STARTED;
    }
    if (t >= (sound_1.getDuration() + sound_1.tStart)     && sound_1.status === PsychoJS.Status.STARTED) {
      sound_1.stop();  // stop the sound (if longer than duration)
      sound_1.status = PsychoJS.Status.FINISHED;
    }
    
    // *resp* updates
    if (t >= 0.5 && resp.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      resp.tStart = t;  // (not accounting for frame time here)
      resp.frameNStart = frameN;  // exact frame index
      
      // keyboard checking is just starting
      psychoJS.window.callOnFlip(function() { resp.clock.reset(); });  // t=0 on next screen flip
      psychoJS.window.callOnFlip(function() { resp.start(); }); // start on screen flip
      psychoJS.window.callOnFlip(function() { resp.clearEvents(); });
    }

    if (resp.status === PsychoJS.Status.STARTED) {
      let theseKeys = resp.getKeys({keyList: ['left', 'right'], waitRelease: false});
      _resp_allKeys = _resp_allKeys.concat(theseKeys);
      if (_resp_allKeys.length > 0) {
        resp.keys = _resp_allKeys[_resp_allKeys.length - 1].name;  // just the last key pressed
        resp.rt = _resp_allKeys[_resp_allKeys.length - 1].rt;
        // a response ends the routine
        continueRoutine = false;
      }
    }
    
    
    // *eefree_p* updates
    if (t >= 0.5 && eefree_p.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      eefree_p.tStart = t;  // (not accounting for frame time here)
      eefree_p.frameNStart = frameN;  // exact frame index
      
      eefree_p.setAutoDraw(true);
    }

    
    // *offree_practice* updates
    if (t >= 0.5 && offree_practice.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      offree_practice.tStart = t;  // (not accounting for frame time here)
      offree_practice.frameNStart = frameN;  // exact frame index
      
      offree_practice.setAutoDraw(true);
    }

    // check for quit (typically the Esc key)
    if (psychoJS.experiment.experimentEnded || psychoJS.eventManager.getKeys({keyList:['escape']}).length > 0) {
      return quitPsychoJS('The [Escape] key was pressed. Goodbye!', false);
    }
    
    // check if the Routine should terminate
    if (!continueRoutine) {  // a component has requested a forced-end of Routine
      return Scheduler.Event.NEXT;
    }
    
    continueRoutine = false;  // reverts to True if at least one component still running
    practiceComponents.forEach( function(thisComponent) {
      if ('status' in thisComponent && thisComponent.status !== PsychoJS.Status.FINISHED) {
        continueRoutine = true;
      }
    });
    
    // refresh the screen if continuing
    if (continueRoutine) {
      return Scheduler.Event.FLIP_REPEAT;
    } else {
      return Scheduler.Event.NEXT;
    }
  };
}


function practiceRoutineEnd(snapshot) {
  return function () {
    //------Ending Routine 'practice'-------
    practiceComponents.forEach( function(thisComponent) {
      if (typeof thisComponent.setAutoDraw === 'function') {
        thisComponent.setAutoDraw(false);
      }
    });
    sound_1.stop();  // ensure sound has stopped at end of routine
    psychoJS.experiment.addData('resp.keys', resp.keys);
    if (typeof resp.keys !== 'undefined') {  // we had a response
        psychoJS.experiment.addData('resp.rt', resp.rt);
        routineTimer.reset();
        }
    
    resp.stop();
    // the Routine "practice" was not non-slip safe, so reset the non-slip timer
    routineTimer.reset();
    
    return Scheduler.Event.NEXT;
  };
}


var _gotResponse_allKeys;
var got_itComponents;
function got_itRoutineBegin(snapshot) {
  return function () {
    //------Prepare to start Routine 'got_it'-------
    t = 0;
    got_itClock.reset(); // clock
    frameN = -1;
    // update component parameters for each repeat
    gotResponse.keys = undefined;
    gotResponse.rt = undefined;
    _gotResponse_allKeys = [];
    // keep track of which components have finished
    got_itComponents = [];
    got_itComponents.push(gotIT);
    got_itComponents.push(gotResponse);
    
    got_itComponents.forEach( function(thisComponent) {
      if ('status' in thisComponent)
        thisComponent.status = PsychoJS.Status.NOT_STARTED;
       });
    
    return Scheduler.Event.NEXT;
  };
}


function got_itRoutineEachFrame(snapshot) {
  return function () {
    //------Loop for each frame of Routine 'got_it'-------
    let continueRoutine = true; // until we're told otherwise
    // get current time
    t = got_itClock.getTime();
    frameN = frameN + 1;// number of completed frames (so 0 is the first frame)
    // update/draw components on each frame
    
    // *gotIT* updates
    if (t >= 0.75 && gotIT.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      gotIT.tStart = t;  // (not accounting for frame time here)
      gotIT.frameNStart = frameN;  // exact frame index
      
      gotIT.setAutoDraw(true);
    }

    frameRemains = 0.75 + 1.0 - psychoJS.window.monitorFramePeriod * 0.75;  // most of one frame period left
    if (gotIT.status === PsychoJS.Status.STARTED && t >= frameRemains) {
      gotIT.setAutoDraw(false);
    }
    
    // *gotResponse* updates
    if (t >= 1.0 && gotResponse.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      gotResponse.tStart = t;  // (not accounting for frame time here)
      gotResponse.frameNStart = frameN;  // exact frame index
      
      // keyboard checking is just starting
      psychoJS.window.callOnFlip(function() { gotResponse.clock.reset(); });  // t=0 on next screen flip
      psychoJS.window.callOnFlip(function() { gotResponse.start(); }); // start on screen flip
      psychoJS.window.callOnFlip(function() { gotResponse.clearEvents(); });
    }

    if (gotResponse.status === PsychoJS.Status.STARTED) {
      let theseKeys = gotResponse.getKeys({keyList: ['space'], waitRelease: false});
      _gotResponse_allKeys = _gotResponse_allKeys.concat(theseKeys);
      if (_gotResponse_allKeys.length > 0) {
        gotResponse.keys = _gotResponse_allKeys[_gotResponse_allKeys.length - 1].name;  // just the last key pressed
        gotResponse.rt = _gotResponse_allKeys[_gotResponse_allKeys.length - 1].rt;
        // a response ends the routine
        continueRoutine = false;
      }
    }
    
    // check for quit (typically the Esc key)
    if (psychoJS.experiment.experimentEnded || psychoJS.eventManager.getKeys({keyList:['escape']}).length > 0) {
      return quitPsychoJS('The [Escape] key was pressed. Goodbye!', false);
    }
    
    // check if the Routine should terminate
    if (!continueRoutine) {  // a component has requested a forced-end of Routine
      return Scheduler.Event.NEXT;
    }
    
    continueRoutine = false;  // reverts to True if at least one component still running
    got_itComponents.forEach( function(thisComponent) {
      if ('status' in thisComponent && thisComponent.status !== PsychoJS.Status.FINISHED) {
        continueRoutine = true;
      }
    });
    
    // refresh the screen if continuing
    if (continueRoutine) {
      return Scheduler.Event.FLIP_REPEAT;
    } else {
      return Scheduler.Event.NEXT;
    }
  };
}


function got_itRoutineEnd(snapshot) {
  return function () {
    //------Ending Routine 'got_it'-------
    got_itComponents.forEach( function(thisComponent) {
      if (typeof thisComponent.setAutoDraw === 'function') {
        thisComponent.setAutoDraw(false);
      }
    });
    psychoJS.experiment.addData('gotResponse.keys', gotResponse.keys);
    if (typeof gotResponse.keys !== 'undefined') {  // we had a response
        psychoJS.experiment.addData('gotResponse.rt', gotResponse.rt);
        routineTimer.reset();
        }
    
    gotResponse.stop();
    // the Routine "got_it" was not non-slip safe, so reset the non-slip timer
    routineTimer.reset();
    
    return Scheduler.Event.NEXT;
  };
}


var _resp_2_allKeys;
var practice_2Components;
function practice_2RoutineBegin(snapshot) {
  return function () {
    //------Prepare to start Routine 'practice_2'-------
    t = 0;
    practice_2Clock.reset(); // clock
    frameN = -1;
    // update component parameters for each repeat
    sound_2 = new sound.Sound({
    win: psychoJS.window,
    value: stimuli,
    secs: -1,
    });
    sound_2.setVolume(1);
    resp_2.keys = undefined;
    resp_2.rt = undefined;
    _resp_2_allKeys = [];
    // keep track of which components have finished
    practice_2Components = [];
    practice_2Components.push(cross_tr_2);
    practice_2Components.push(sound_2);
    practice_2Components.push(resp_2);
    practice_2Components.push(eefree_p_2);
    practice_2Components.push(offree_practice_2);
    
    practice_2Components.forEach( function(thisComponent) {
      if ('status' in thisComponent)
        thisComponent.status = PsychoJS.Status.NOT_STARTED;
       });
    
    return Scheduler.Event.NEXT;
  };
}


function practice_2RoutineEachFrame(snapshot) {
  return function () {
    //------Loop for each frame of Routine 'practice_2'-------
    let continueRoutine = true; // until we're told otherwise
    // get current time
    t = practice_2Clock.getTime();
    frameN = frameN + 1;// number of completed frames (so 0 is the first frame)
    // update/draw components on each frame
    
    // *cross_tr_2* updates
    if (t >= 0.0 && cross_tr_2.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      cross_tr_2.tStart = t;  // (not accounting for frame time here)
      cross_tr_2.frameNStart = frameN;  // exact frame index
      
      cross_tr_2.setAutoDraw(true);
    }

    frameRemains = 0.0 + 0.4 - psychoJS.window.monitorFramePeriod * 0.75;  // most of one frame period left
    if (cross_tr_2.status === PsychoJS.Status.STARTED && t >= frameRemains) {
      cross_tr_2.setAutoDraw(false);
    }
    // start/stop sound_2
    if (t >= 0.5 && sound_2.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      sound_2.tStart = t;  // (not accounting for frame time here)
      sound_2.frameNStart = frameN;  // exact frame index
      
      psychoJS.window.callOnFlip(function(){ sound_2.play(); });  // screen flip
      sound_2.status = PsychoJS.Status.STARTED;
    }
    if (t >= (sound_2.getDuration() + sound_2.tStart)     && sound_2.status === PsychoJS.Status.STARTED) {
      sound_2.stop();  // stop the sound (if longer than duration)
      sound_2.status = PsychoJS.Status.FINISHED;
    }
    
    // *resp_2* updates
    if (t >= 0.5 && resp_2.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      resp_2.tStart = t;  // (not accounting for frame time here)
      resp_2.frameNStart = frameN;  // exact frame index
      
      // keyboard checking is just starting
      psychoJS.window.callOnFlip(function() { resp_2.clock.reset(); });  // t=0 on next screen flip
      psychoJS.window.callOnFlip(function() { resp_2.start(); }); // start on screen flip
      psychoJS.window.callOnFlip(function() { resp_2.clearEvents(); });
    }

    if (resp_2.status === PsychoJS.Status.STARTED) {
      let theseKeys = resp_2.getKeys({keyList: ['left', 'right'], waitRelease: false});
      _resp_2_allKeys = _resp_2_allKeys.concat(theseKeys);
      if (_resp_2_allKeys.length > 0) {
        resp_2.keys = _resp_2_allKeys[_resp_2_allKeys.length - 1].name;  // just the last key pressed
        resp_2.rt = _resp_2_allKeys[_resp_2_allKeys.length - 1].rt;
        // a response ends the routine
        continueRoutine = false;
      }
    }
    
    
    // *eefree_p_2* updates
    if (t >= 0.5 && eefree_p_2.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      eefree_p_2.tStart = t;  // (not accounting for frame time here)
      eefree_p_2.frameNStart = frameN;  // exact frame index
      
      eefree_p_2.setAutoDraw(true);
    }

    
    // *offree_practice_2* updates
    if (t >= 0.5 && offree_practice_2.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      offree_practice_2.tStart = t;  // (not accounting for frame time here)
      offree_practice_2.frameNStart = frameN;  // exact frame index
      
      offree_practice_2.setAutoDraw(true);
    }

    // check for quit (typically the Esc key)
    if (psychoJS.experiment.experimentEnded || psychoJS.eventManager.getKeys({keyList:['escape']}).length > 0) {
      return quitPsychoJS('The [Escape] key was pressed. Goodbye!', false);
    }
    
    // check if the Routine should terminate
    if (!continueRoutine) {  // a component has requested a forced-end of Routine
      return Scheduler.Event.NEXT;
    }
    
    continueRoutine = false;  // reverts to True if at least one component still running
    practice_2Components.forEach( function(thisComponent) {
      if ('status' in thisComponent && thisComponent.status !== PsychoJS.Status.FINISHED) {
        continueRoutine = true;
      }
    });
    
    // refresh the screen if continuing
    if (continueRoutine) {
      return Scheduler.Event.FLIP_REPEAT;
    } else {
      return Scheduler.Event.NEXT;
    }
  };
}


function practice_2RoutineEnd(snapshot) {
  return function () {
    //------Ending Routine 'practice_2'-------
    practice_2Components.forEach( function(thisComponent) {
      if (typeof thisComponent.setAutoDraw === 'function') {
        thisComponent.setAutoDraw(false);
      }
    });
    sound_2.stop();  // ensure sound has stopped at end of routine
    psychoJS.experiment.addData('resp_2.keys', resp_2.keys);
    if (typeof resp_2.keys !== 'undefined') {  // we had a response
        psychoJS.experiment.addData('resp_2.rt', resp_2.rt);
        routineTimer.reset();
        }
    
    resp_2.stop();
    // the Routine "practice_2" was not non-slip safe, so reset the non-slip timer
    routineTimer.reset();
    
    return Scheduler.Event.NEXT;
  };
}


var thanksComponents;
function thanksRoutineBegin(snapshot) {
  return function () {
    //------Prepare to start Routine 'thanks'-------
    t = 0;
    thanksClock.reset(); // clock
    frameN = -1;
    routineTimer.add(2.000000);
    // update component parameters for each repeat
    // keep track of which components have finished
    thanksComponents = [];
    thanksComponents.push(thanksText);
    
    thanksComponents.forEach( function(thisComponent) {
      if ('status' in thisComponent)
        thisComponent.status = PsychoJS.Status.NOT_STARTED;
       });
    
    return Scheduler.Event.NEXT;
  };
}


function thanksRoutineEachFrame(snapshot) {
  return function () {
    //------Loop for each frame of Routine 'thanks'-------
    let continueRoutine = true; // until we're told otherwise
    // get current time
    t = thanksClock.getTime();
    frameN = frameN + 1;// number of completed frames (so 0 is the first frame)
    // update/draw components on each frame
    
    // *thanksText* updates
    if (t >= 0.0 && thanksText.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      thanksText.tStart = t;  // (not accounting for frame time here)
      thanksText.frameNStart = frameN;  // exact frame index
      
      thanksText.setAutoDraw(true);
    }

    frameRemains = 0.0 + 2.0 - psychoJS.window.monitorFramePeriod * 0.75;  // most of one frame period left
    if (thanksText.status === PsychoJS.Status.STARTED && t >= frameRemains) {
      thanksText.setAutoDraw(false);
    }
    // check for quit (typically the Esc key)
    if (psychoJS.experiment.experimentEnded || psychoJS.eventManager.getKeys({keyList:['escape']}).length > 0) {
      return quitPsychoJS('The [Escape] key was pressed. Goodbye!', false);
    }
    
    // check if the Routine should terminate
    if (!continueRoutine) {  // a component has requested a forced-end of Routine
      return Scheduler.Event.NEXT;
    }
    
    continueRoutine = false;  // reverts to True if at least one component still running
    thanksComponents.forEach( function(thisComponent) {
      if ('status' in thisComponent && thisComponent.status !== PsychoJS.Status.FINISHED) {
        continueRoutine = true;
      }
    });
    
    // refresh the screen if continuing
    if (continueRoutine && routineTimer.getTime() > 0) {
      return Scheduler.Event.FLIP_REPEAT;
    } else {
      return Scheduler.Event.NEXT;
    }
  };
}


function thanksRoutineEnd(snapshot) {
  return function () {
    //------Ending Routine 'thanks'-------
    thanksComponents.forEach( function(thisComponent) {
      if (typeof thisComponent.setAutoDraw === 'function') {
        thisComponent.setAutoDraw(false);
      }
    });
    return Scheduler.Event.NEXT;
  };
}


function endLoopIteration(scheduler, snapshot) {
  // ------Prepare for next entry------
  return function () {
    if (typeof snapshot !== 'undefined') {
      // ------Check if user ended loop early------
      if (snapshot.finished) {
        // Check for and save orphaned data
        if (psychoJS.experiment.isEntryEmpty()) {
          psychoJS.experiment.nextEntry(snapshot);
        }
        scheduler.stop();
      } else {
        const thisTrial = snapshot.getCurrentTrial();
        if (typeof thisTrial === 'undefined' || !('isTrials' in thisTrial) || thisTrial.isTrials) {
          psychoJS.experiment.nextEntry(snapshot);
        }
      }
    return Scheduler.Event.NEXT;
    }
  };
}


function importConditions(currentLoop) {
  return function () {
    psychoJS.importAttributes(currentLoop.getCurrentTrial());
    return Scheduler.Event.NEXT;
    };
}


function quitPsychoJS(message, isCompleted) {
  // Check for and save orphaned data
  if (psychoJS.experiment.isEntryEmpty()) {
    psychoJS.experiment.nextEntry();
  }
  psychoJS.window.close();
  psychoJS.quit({message: message, isCompleted: isCompleted});
  
  return Scheduler.Event.QUIT;
}
