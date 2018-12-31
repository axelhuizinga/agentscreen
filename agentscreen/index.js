


const puppeteer = require('puppeteer');

function AgentScreen(loginUrl)
{
    this.loginUrl = loginUrl;
}

AgentScreen.prototype.run = async function(delay=5000) {    
    //console.log(loginUrl);
    this.browser = await puppeteer.launch({args: ['--no-sandbox']});
    this.page = await this.browser.newPage();
    await this.page.goto(this.loginUrl);
    await Promise.all([
        this.page.click("input[type=submit]"),
        this.page.waitForNavigation({ waitUntil: 'networkidle0' }),
    ]);
    await wait(delay);
    await this.page.screenshot({ path: 'screenshots/agentscreen.png' });
    console.log(await this.page.content());
}

AgentScreen.prototype.screenshot = async function()
{
    return await this.page.screenshot({type:'jpeg'});
}

AgentScreen.prototype.close = function()
{
    this.browser.close();
}
    
function wait(ms) {
    return new Promise(resolve => {
        setTimeout(resolve, ms);
    });
}

module.exports = {AgentScreen:AgentScreen}