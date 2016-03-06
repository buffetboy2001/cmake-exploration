//
// Created by Stuart on 3/5/2016.
//
#include <logger.h>
#include <consoleappender.h>
#include <loglevel.h>
#include <layout.h>
#include <ndc.h>
#include <loggingmacros.h>

using namespace log4cplus;

int main(int argc, char* argv[]) {
    SharedAppenderPtr myAppender(new ConsoleAppender());
    myAppender->setName("myAppenderName");
    std::auto_ptr<Layout> myLayout = std::auto_ptr<Layout>(new log4cplus::TTCCLayout());
    myAppender->setLayout( myLayout );
    initialize(); // start logging system
    Logger applogger = Logger::getInstance("myapp");
    applogger.addAppender(myAppender);
    LOG4CPLUS_INFO(applogger,"Starting logging"); // say hello
}