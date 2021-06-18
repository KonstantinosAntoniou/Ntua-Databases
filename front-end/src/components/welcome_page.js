import React from 'react';
import NavBar from "./NavBar";
import DateFnsUtils from '@date-io/date-fns';
import {
    makeStyles,
    FormControl,
    InputLabel,
    Input,
    Box,
    Button,
    Paper
} from "@material-ui/core";
import {
    MuiPickersUtilsProvider,
    KeyboardDatePicker,
} from '@material-ui/pickers';
import {useHistory} from "react-router-dom";

const useStyles = makeStyles((theme) => ({
    root: {
        //flexGrow: 1
    },
    containerC: {
        paddingLeft: 80,
        paddingRight: 80,
        width: '80%',
        paddingTop: 40

    },
    containerN: {
        paddingLeft: 80,
        paddingRight: 80,
        //width: '80%',
        paddingTop: 0
    },
    header: {
        paddingLeft: 35,
        paddingTop: 10
        //margin: 10
    },
    boxButton: {
        paddingLeft: theme.spacing(4)
    },
    button: {
        textTransform: 'none'
    }
}));

function convertDate(date) {
    const month = ("0" + (date.getMonth() + 1)).slice(-2);
    const day = ("0" + date.getDate()).slice(-2);
    return [date.getFullYear(), month, day].join("");
}

export default function Sessions() {

    const classes = useStyles();
    const history = useHistory();


    /***************************************************************************************
     * Customers info
     ***************************************************************************************/

    const CustomersSubmitHandler = event => {
        event.preventDefault();
        history.push(`/costumers/` );
    }

    /***************************************************************************************
     * Rooms info
     ***************************************************************************************/

    const RoomsSubmitHandler = event => {
        event.preventDefault();
        history.push(`/rooms/` );
    }

    /***************************************************************************************
     * More Info
     ***************************************************************************************/

    const MoreInfoSubmitHandler = event => {
        event.preventDefault();
        history.push(`/moreInfo/` );
    }


    return (


        <div className={classes.root}>
            <NavBar/>

            <div className={classes.containerC}>
                <Paper elevation={6} className={classes.paper}>
                    <div className={classes.header}>
                        <h1>Welcome to JKZ Hotel! </h1>
                    </div>


                        <Box display="flex" flexDirection="row" p={1} m={3} bgcolor="background.paper">

                        </Box>


                </Paper>
            </div>

            <div className={classes.containerC}>
                <Paper elevation={6} className={classes.paper}>
                    <div className={classes.header}>
                        <h3>Customers Informations </h3>
                    </div>
                    <form autoComplete="off" onSubmit={CustomersSubmitHandler}>

                        <Box display="flex" flexDirection="row" p={2} m={2} bgcolor="background.paper">
                            <Box className={classes.boxButton} p={1} m={1}>
                                <Button className={classes.button} variant="contained" color="primary" type="submit"
                                        onSubmit={CustomersSubmitHandler}>
                                    Search
                                </Button>
                            </Box>
                        </Box>
                    </form>
                </Paper>
            </div>

            <div className={classes.containerC}>
                <Paper elevation={6} className={classes.paper}>
                    <div className={classes.header}>
                        <h3>Rooms Informations </h3>
                    </div>
                    <form autoComplete="off" onSubmit={RoomsSubmitHandler}>

                        <Box display="flex" flexDirection="row" p={2} m={2} bgcolor="background.paper">
                            <Box className={classes.boxButton} p={1} m={1}>
                                <Button className={classes.button} variant="contained" color="primary" type="submit"
                                        onSubmit={RoomsSubmitHandler}>
                                    Search
                                </Button>
                            </Box>
                        </Box>
                    </form>
                </Paper>
            </div>

            <div className={classes.containerC}>
                <Paper elevation={6} className={classes.paper}>
                    <div className={classes.header}>
                        <h3>More Informations </h3>
                    </div>
                    <form autoComplete="off" onSubmit={MoreInfoSubmitHandler}>

                        <Box display="flex" flexDirection="row" p={2} m={2} bgcolor="background.paper">
                            <Box className={classes.boxButton} p={1} m={1}>
                                <Button className={classes.button} variant="contained" color="primary" type="submit"
                                        onSubmit={MoreInfoSubmitHandler}>
                                    Search
                                </Button>
                            </Box>
                        </Box>
                    </form>
                </Paper>
            </div>

        </div>

    )
        ;
}