import { styled, run, React } from "uebersicht";

const token = "1d1bed3ba11820f26b41b48c98b861f03331184c";

export const command = `
osascript -e 'tell application "Spotify" to artist of current track' &&
osascript -e 'tell application "Spotify" to name of current track' &&
osascript -e 'tell application "Spotify" to artwork url of current track'
`;

export const updateState = (event, previousState) => {
  return event;
};

export const refreshFrequency = 1000 * 30;

export const className = `
  bottom: 5px;
  left: 100px;
  right: 300px;
  height: 65px;
  display: grid;
  // border: 1px dashed yellow;
  grid-template-columns: auto 1fr auto;
  grid-template-rows: 1fr;
  grid-template-areas: "some cal spotify";
  color: #ccc;
  -webkit-user-select: none;
  font-family: 'Roboto Condensed', Roboto, sans-serif;

  h1, h2, h3, h4, h5, h6 {
    margin: 0;
    padding: 0;
  }

  section.cal {
    grid-area: cal;
    height: 100%;
  }
  section.song {
    grid-area: spotify;
    height: 100%;
    display: grid;
    margin-left: 2rem;
    grid-template-columns: auto 1fr;
    grid-template-rows: 1fr 1fr;
    grid-template-areas: 
      "cover title"
      "cover artist";
      > h3 { grid-area: title; display: flex; align-items: flex-end; padding-bottom: 3px; }
      > div { grid-area: artist; display: flex; align-items: flex-start; }
      > .cover { 
        grid-area: cover;
        display: flex;
        align-items: center;
        img {
          height: 60px; 
          width: 60px;
          background-size: cover;
          margin-right: 10px;
          border-radius: 10%;
          border: 2px solid rgba(255, 255, 255, 0.5);
        }
      }
  }
`;

/////////// CALENDAR
import * as dateFns from "date-fns";

const getMonthDays = () => {
  const now = new Date();
  const daysInMonth = new Date(
    now.getFullYear(),
    now.getMonth() + 1,
    0
  ).getDate();
  return new Array(daysInMonth)
    .fill(1)
    .map((val, i) => new Date(now.getFullYear(), now.getMonth(), i + 1));
};

const Day = styled.div`
  flex: 1;
  margin: 0 4px;
  border-radius: 4px;
  background-color: rgba(
    255,
    255,
    255,
    ${({ weekend, previous }) =>
      previous ? "transparent" : weekend ? ".05" : ".1"}
  );
  border: 1px solid
    ${({ previous, current, weekend }) => {
      if (current) return "white";
      return `rgba(255, 255, 255, ${weekend ? ".05" : ".1"})`;
    }};
  color: ${({ previous }) =>
    previous ? "rgba(200, 200, 200, .3)" : "rgba(200, 200, 200, 1)"};
  padding: 0.5rem;
  text-align: center;
  -webkit-backdrop-filter: blur(6px);

  &:hover {
    cursor: pointer;
    background-color: rgba(255, 255, 255, 0.3);
  }
`;

const CalContainer = styled.div`
  display: flex;
  flex-flow: row nowrap;
  align-items: center;
  justify-content: center;
  height: 100%;
`;

const Calendar = ({ className }) => {
  return (
    <CalContainer className={className}>
      {getMonthDays().map((d, i) => (
        <Day
          key={i}
          previous={d.getDate() < new Date().getDate()}
          current={d.getDate() === new Date().getDate()}
          weekend={[0, 6].includes(d.getDay())}
          onClick={() =>
            run(`./cal.widget/open-calendar ${dateFns.format(d, "d/MM/yyyy")}`)
              .then((r) => console.log(r))
              .catch((e) => console.error(e))
          }
        >
          {dateFns.format(d, "do")}
          <br />
          <strong>{dateFns.format(d, "iii").toUpperCase()}</strong>
        </Day>
      ))}
    </CalContainer>
  );
};
/////////// END: CALENDAR

export const render = ({ output, data = [] }, dispatch) => {
  const [artist, title, url] = output.split("\n");
  return (
    <React.Fragment>
      <section class="cal">
        <Calendar />
      </section>
      <section class="song">
        <h3>
          <span>
            <strong>{title}</strong>
          </span>
        </h3>
        <div class="artist">
          <span>
            by <strong>{artist}</strong>
          </span>
        </div>
        <div class="cover">
          <img src={url} />
        </div>
      </section>
    </React.Fragment>
  );
};
