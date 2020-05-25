class SoundPlayer {
    static init () {
        this.sound = document.createElement("audio")
        this.sound.setAttribute("preload", "auto")
        this.sound.setAttribute("controls", "none")
        this.sound.style.display = "none"
        document.body.appendChild(this.sound)
        document.addEventListener('click', () => { SoundPlayer.onClick() })
    }

    static play (soundUrl) {
        this.sound.src = soundUrl
        this.sound.play()
    }

    static pause () {
        this.sound.pause()
    }

    static getCurrentTime () {
        return this.sound.currentTime
    }

    static onClick () {
        if (this.sound.currentTime == 0) {
            this.sound.play()
        }
    }
}

SoundPlayer.init()

