import datetime
import traceback
from typing import List, Optional

import bs4
import requests
import slackweb
from environs import Env

env = Env()

SLACK_WEBHOOK_URL = env.str(
    "SLACK_WEBHOOK_URL")


class Slack:
    def __init__(self, url):
        self.url = url
        if url:
            self.slack = slackweb.Slack(url)
        else:
            self.slack = None

    def notify(self, *args, **kwargs):
        if self.slack is not None:
            self.slack.notify(**kwargs)


slack = Slack(SLACK_WEBHOOK_URL)


def run(event, context):
    try:
        url = "https://oriental-lounge.com/"
        with requests.get(url) as res:
            soup: bs4.BeautifulSoup = bs4.BeautifulSoup(
                res.content, "html.parser")
        shops: List[bs4.BeautifulSoup] = soup.find_all("div", class_="shop")
        tz_jst = datetime.timezone(datetime.timedelta(hours=9))
        current_datetime = datetime.datetime.now(tz_jst)
        data = []
        data.append({
            "type": "section",
            "text": {
                "type": "mrkdwn",
                "text": f"只今の時刻は {current_datetime.strftime('%Y/%m/%d %H:%M:%S')} です"
            }
        })
        for shop in shops:
            shop_name = get_shop_name(shop)
            man_num = get_man_num(shop)
            woman_num = get_woman_num(shop)
            data.append({"type": "divider"})
            data.append({
                "type": "section",
                "text": {
                    "type": "mrkdwn",
                    "text": f":house:: {shop_name}\n:man:: {man_num}\n:woman:: {woman_num}"
                }
            })
        slack.notify(blocks=data)
    except Exception:
        slack.notify(text=traceback.format_exc())


def get_shop_name(shop_element: bs4.BeautifulSoup) -> str:
    shop_name_tag: bs4.BeautifulSoup = shop_element.find(
        "div", class_="shop_name")
    text = shop_name_tag.get_text()
    shop_name = ''
    for t in text.splitlines():
        tmp_text = t.strip()
        if tmp_text:
            shop_name = tmp_text
            break
    return shop_name


def get_man_num(shop_element: bs4.BeautifulSoup) -> int:
    man_element: bs4.BeautifulSoup = shop_element.find("li", class_="man")
    cnt: Optional[str] = man_element.string
    return int(cnt) if cnt and cnt.isdigit() else 0


def get_woman_num(shop_element: bs4.BeautifulSoup) -> int:
    woman_element: bs4.BeautifulSoup = shop_element.find("li", class_="woman")
    cnt: Optional[str] = woman_element.string
    return int(cnt) if cnt and cnt.isdigit() else 0


if __name__ == "__main__":
    run(1, 1)
