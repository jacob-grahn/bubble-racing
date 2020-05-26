var engine = new Engine;
var setStatusMode;
var setStatusNotice;

(function() {

    const EXECUTABLE_NAME = '$GODOT_BASENAME';
    const MAIN_PACK = '$GODOT_BASENAME.pck';
    const EXTRA_ARGS = JSON.parse('$GODOT_ARGS');
    const INDETERMINATE_STATUS_STEP_MS = 100;

    var canvas = document.getElementById('canvas');
    var statusProgress = document.getElementById('status-progress');
    var statusProgressInner = document.getElementById('status-progress-inner');
    var statusIndeterminate = document.getElementById('status-indeterminate');
    var statusNotice = document.getElementById('status-notice');

    var initializing = true;
    var statusMode = 'hidden';

    var animationCallbacks = [];
    function animate(time) {
        animationCallbacks.forEach(callback => callback(time));
        requestAnimationFrame(animate);
    }
    requestAnimationFrame(animate);

    function adjustCanvasDimensions() {
        var scale = window.devicePixelRatio || 1;
        var width = window.innerWidth;
        var height = window.innerHeight;
        canvas.width = width * scale;
        canvas.height = height * scale;
    }
    animationCallbacks.push(adjustCanvasDimensions);
    adjustCanvasDimensions();

    setStatusMode = function setStatusMode(mode) {

        if (statusMode === mode || !initializing)
            return;
        [statusProgress, statusIndeterminate, statusNotice].forEach(elem => {
            elem.style.display = 'none';
        });
        animationCallbacks = animationCallbacks.filter(function(value) {
            return (value != animateStatusIndeterminate);
        });
        switch (mode) {
            case 'progress':
                statusProgress.style.display = 'block';
                break;
            case 'indeterminate':
                statusIndeterminate.style.display = 'block';
                animationCallbacks.push(animateStatusIndeterminate);
                break;
            case 'notice':
                statusNotice.style.display = 'block';
                break;
            case 'hidden':
                break;
            default:
                throw new Error('Invalid status mode');
        }
        statusMode = mode;
    }

    function animateStatusIndeterminate(ms) {

        var i = Math.floor(ms / INDETERMINATE_STATUS_STEP_MS % 8);
        if (statusIndeterminate.children[i].style.borderTopColor == '') {
            Array.prototype.slice.call(statusIndeterminate.children).forEach(child => {
                child.style.borderTopColor = '';
            });
            statusIndeterminate.children[i].style.borderTopColor = '#dfdfdf';
        }
    }

    setStatusNotice = function setStatusNotice(text) {

        while (statusNotice.lastChild) {
            statusNotice.removeChild(statusNotice.lastChild);
        }
        var lines = text.split('\n');
        lines.forEach((line) => {
            statusNotice.appendChild(document.createTextNode(line));
            statusNotice.appendChild(document.createElement('br'));
        });
    };

    engine.setProgressFunc((current, total) => {

        if (total > 0) {
            statusProgressInner.style.width = current/total * 100 + '%';
            setStatusMode('progress');
            if (current === total) {
                // wait for progress bar animation
                setTimeout(() => {
                    setStatusMode('indeterminate');
                }, 500);
            }
        } else {
            setStatusMode('indeterminate');
        }
    });

    function displayFailureNotice(err) {
        var msg = err.message || err;
        console.error(msg);
        setStatusNotice(msg);
        setStatusMode('notice');
        initializing = false;
    };

    if (!Engine.isWebGLAvailable()) {
        displayFailureNotice('WebGL not available');
    } else {
        setStatusMode('indeterminate');
        engine.setCanvas(canvas);
        engine.startGame(EXECUTABLE_NAME, MAIN_PACK, EXTRA_ARGS).then(() => {
            setStatusMode('hidden');
            initializing = false;
        }, displayFailureNotice);
    }
})();
